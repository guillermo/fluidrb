module FluidDB 
  class Tag
    def self.create(namespace,options)
      connection = options.delete(:connection) || FluidDB.connection
      obj = connection.post("/tags/#{namespace}",:payload => options)
      new({:connection => connection, :namespace => namespace}.merge(options).merge(obj))
    end
    
    def initialize(options = {})
      @options = options
      @options[:connection] ||= FluidDB.connection
      if @options[:path]
        path = @options[:path].split('/')
        @options[:namespace] = path[0..-2].join('/')
        @options[:name] = path.last
      end
    end
    
    def self.get(path,options = {})
      connection = options.delete(:connection) || FluidDB.connection
      obj = connection.get("/tags/#{path}",:query => options)
      new({:connection => connection, :path => path}.merge(options).merge(obj))
    end
    
    def delete
      @options[:connection].delete("/tags/#{path}") && true
    end
      
    def namespace
      @options[:namespace] ||= URI.parse(@options[:URI]).path.split('/')[0..-2].join('/')
    end
    
    def name
      @options[:name] ||= URI.parse(@options[:URI]).split('/').last
    end
    
    def path
      "#{namespace}/#{name}"
    end
    
    def description
      @options[:description] or raise FluidDB::Error.new('You should get with option :returnDescription => true')
    end
      
    def description=(description)
      @options[:connection].put("/tags/#{path}",:payload => {:description => description})
      @options[:description] = description
    end
    
    def id
      @options[:id]
    end
    
    def indexed?
      @options[:indexed]
    end 
  end
end