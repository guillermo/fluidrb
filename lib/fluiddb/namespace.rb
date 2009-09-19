module FluidDB
  class Namespace #:nodoc:
    
    def self.create(namespace,options)      
      connection = options.delete(:connection) || FluidDB.connection
      
      obj = connection.post("/namespaces/#{namespace}", :payload => options)
      new({:connection => connection, :path => "#{namespace}/#{options[:name]}"}.merge(options).merge(obj))
    end
    
    def self.get(namespace, options = {})
      connection = options.delete(:connection) || FluidDB.connection
      
      path = "/namespaces/#{namespace}"
      obj = connection.get( path, :query => options)
      new({:connection => connection, :path => namespace}.merge(options).merge(obj))
    end
    
    def initialize(options = {}) #:nodoc:
      @options = options
      @options[:connection] ||= FluidDB.connection
      @options[:path] ||= @options[:namespace]
      @options[:name] ||= @options[:path].split('/').last
    end
    
    def delete
      @options[:connection].delete("/namespaces/#{path}") && true
    end
    
    def description
      @options[:description] ||= fetch(:description)
    end
    
    def id
      @options[:id] ||= fetch(:id)
    end
    
    def name
      @options[:name]
    end
    
    def path
      @options[:path]
    end
    
    def namespace
      path
    end
    
    def namespaceNames
      @options[:namespaceNames] ||= fetch(:namespaceNames)
    end
    
    def tagNames
      @options[:tagNames] ||= fetch(:tagNames)
    end
    
    def fetch(what = :all)
      options = {}
      path = "/namespaces/#{namespace}"
      c = @options[:connection]
      case what
      when :id
        c.get( path )[:id]
      when :description
        c.get( path,:query => {:returnDescription => true} )[:description]
      when :namespaceNames
        c.get( path,:query => {:returnNamespaces => true} )[:namespaceNames]
      when :tagNames
        c.get( path,:query => {:returnTags => true} )[:tagNames]
      else
        options = { :returnDescription => true, :returnNamespaces => true, :returnTags => true }
        @options.merge( c.get( path, :query => {:returnTags => true}))
        self
      end
    end

  end
end
