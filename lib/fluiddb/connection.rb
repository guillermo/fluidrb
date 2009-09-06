
module FluidDB
  class << self

    # Set credentials
    def set_credentials(user,pass,server = 'fluiddb.fluidinfo.com', scheme = 'http', port = nil)
      @user, @pass, @server, @scheme, @port = user, pass, server, scheme, port
      connect!
    end
    
    def query(method,path,payload={},args={},headers={})

      uri = URI.parse(path)
      uri.query = URI.encode(args.map {|k,v| "#{k}=#{v}"}.join('&'))
      
      headers = DEFAULT_HEADERS.merge(headers)
      if [:post, :put].include?(method)
        payload = payload.to_json 
        headers['Content-length'] = payload.size.to_s
      end
      
      $stderr << "#{method.to_s.upcase}: #{uri.to_s} (#{payload.inspect}, #{headers.inspect})\n" if $debug
      res = query_server(method,uri.to_s,payload,headers)
      
      
      data = ''
      if MIME::Type.simplified(res['content-type']) == 'application/json'
        data = symbolize_keys(JSON.parse(res.body)) if res.body
      else
        data = res.body if res.body
      end
      $stderr << "#{res.code}: #{data.inspect}\n" if $debug
      raise FluidDB::Error.new(data) unless [200,201,204].include?(res.code.to_i)
      
      data
    end
    
    
    protected
    
    attr_accessor :connection, :user, :pass, :server, :scheme
    
    def connect!
      @connection = Net::HTTP.new(@server, @port || @scheme == 'https' ? 443 : 80)
      @connection.use_ssl = true if @scheme == 'https'
      @connection.start
    end

    DEFAULT_HEADERS = {'Content-type' => 'application/json', 'Accept' => 'application/json'}


    def query_server(method, path, payload={}, headers = {})
      req = Net::HTTP.const_get(method.to_s.capitalize).new(path, headers)
      req.basic_auth(@user, @pass) if @user 
      
      if [:post, :put].include?(method)
        @connection.request(req,payload)
      else
        @connection.request(req)
      end
    end
    
    def symbolize_keys(hash)
      hash.inject({}) do |options, (key, value)|
        options[(key.to_sym rescue key) || key] = value
        options
      end
    end
    
    
  end
end
