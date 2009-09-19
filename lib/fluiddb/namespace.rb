module FluidDB
  class Namespace
    
    # Creates a new namespace.
    #
    #   FluidDB::Namespace.create(namepsace, :name => 'namespace_name', :description => 'my new namespace')  => #<FluidDB::Namespace>
    #
    # Params:
    # __namespace__:: Base namespace
    # __name__:: New namespace name
    # __description__:: Namespace description
    # __connection__:: Optional server
    def self.create(namespace,options)      
      connection = options.delete(:connection) || FluidDB.connection
      
      obj = connection.post("/namespaces/#{namespace}", :payload => options)
      new({:connection => connection, :path => "#{namespace}/#{options[:name]}"}.merge(options).merge(obj))
    end
    
    # Get a namespace. If not found, it will raise FluidDB::Error
    #
    #    FluidDB::Namespace.get('test/opinion', :returnTags => true)
    #
    # Params:
    # __namespace__:: Namespace to fetch
    # __:returnTags => true__:: Also fetch the tags inside this namespace.
    # __:returnDescription => true__:: Also fetch the description for the namespace.
    # __:returnNamespaces => true__:: Also fetch the namespaces inside this namespace
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
    
    # Remove the current namespace and return true if success
    def delete
      @options[:connection].delete("/namespaces/#{path}") && true
    end
    
    # Return the namespace description. If not found it will fetch it.
    def description
      @options[:description] ||= fetch(:description)
    end
    
    # Update the description of the current namespace
    def description=(new_desc)
      @options[:connection].put("/namespaces/#{path}", :payload => {:description => new_desc})
      @options[:description] = new_desc
    end
    
    # Return the object id of the namespace
    def id
      @options[:id] 
    end
    
    # Rerturn the name of the namespace
    def name
      @options[:name]
    end
    
    # Return the path/namespace of the namespace
    def path
      @options[:path]
    end
    alias :namespace :path
    
    # Return the collection of namespaces inside current. If not found, it will fetch.
    def namespaceNames
      @options[:namespaceNames] ||= fetch(:namespaceNames)
    end
    
    # Return the tags inside this namespace. If not found, it will fetch
    def tagNames
      @options[:tagNames] ||= fetch(:tagNames)
    end
    
    private
    def fetch(what = :all) #:nodoc:
      options = {}
      path = "/namespaces/#{namespace}"
      c = @options[:connection]
      case what
      when :description
        c.get( path,:query => {:returnDescription => true} )[:description]
      when :namespaceNames
        c.get( path,:query => {:returnNamespaces => true} )[:namespaceNames]
      when :tagNames
        c.get( path,:query => {:returnTags => true} )[:tagNames]
      end
    end

  end
end
