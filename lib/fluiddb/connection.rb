
module FluidDB
  # HTTP 1.1 Connection to fluid servers.
  class Connection
  
    # Default Params
    DEFAULT = {
      :server => 'fluiddb.fluidinfo.com',
      :schema => 'https',
    }

    # Sandbox Params
    SANDBOX = {
      :username => 'test',
      :password => 'test',
      :server => 'sandbox.fluidinfo.com',
      :schema => 'https',
    }

    DEFAULT_HEADERS = {'Content-type' => 'application/json', 'Accept' => 'application/json'}
  
    # Create a new server connection
    #   FluidDB::Connection.new(:test) #will use the sandbox
    #   
    # Params:
    # * __username__
    # * __password__
    # * __server__
    # * __schema__  Could be 'http' or 'https'
    # * __port__ Change default port (443 for https and 80 for http)
    def initialize(args)
      @params = args == :test ? SANDBOX : DEFAULT.merge(args)
      @params[:port] ||= @params[:scheme] == 'https' ? 443 : 80
      connect
    end

    # Reconnect to the server
    # FluidDB::Connection use http 1.1. If you don't use the connection for a while, probably the server will disconnect
    def connect
      @connection = Net::HTTP.new(@params[:server], @params[:port])
      @connection.use_ssl = true if @params[:scheme] == 'https'
      @connection.start
    end

    def head(path, options = {})
      query(:head, path, options)
    end
  
    def put(path, options = {})
      query(:put, path, options)
    end
  
    def get(path,options = {})
      query(:get, path, options)
    end
  
    def post(path,options = {})
      query(:post, path, options)
    end
  
    def delete(path, options = {})
      query(:delete, path, options)
    end

    private
    # Query to the server
    # 
    # Options:
    #  * headers => Special headers
    #  * payload => Data
    #  * query => Query arguments
    def query(method, path, options = {})
      headers = DEFAULT_HEADERS.merge(options[:headers] || {})
      uri = URI.parse(path)
      uri.query = URI.encode((options[:query] || {}).map {|k,v| "#{k}=#{v}"}.join('&'))      
      
      payload = [:post,:put].include?(method) ?  Yajl::Encoder.encode(options[:payload].nil? ? {} : options[:payload]) : nil
      
      $stderr << "#{method.to_s.upcase}: #{uri.to_s} (#{payload.inspect}, #{headers.inspect})\n" if $debug

      req = Net::HTTP.const_get(method.to_s.capitalize).new(uri.to_s, headers)
      req.basic_auth(@params[:username],@params[:password])
      res = @connection.request(req,payload)

      data = res.body || ""
      data = Yajl::Parser.parse(data) if MIME::Type.simplified(res['content-type']) == 'application/json'
      data = symbolize_keys(data) if data.is_a?(Hash)
      
      $stderr << "#{res.code}: #{data.inspect}\n" if $debug

      raise FluidDB::Error.new(data) unless [200,201,204].include?(res.code.to_i)
      data
    end

  
    def symbolize_keys(hash)
      hash.inject({}) do |options, (key, value)|
        options[(key.to_sym rescue key) || key] = value
        options
      end
    end
    
  end
end
