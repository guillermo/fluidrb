module FluidDB 
  class Tag
    
    # Creates a new tag.
    #
    #   FluidDB::Tag.create('test', :indexed => ture, :description => 'good', :name => 'tag_name')  => #<FluidDB::Tag>
    #
    # Params:
    # __name__:: Tag name
    # __description__:: Tag description
    # __indexed__:: true/false
    # __connection__:: Optional server
    def self.create(namespace,options)
      connection = options.delete(:connection) || FluidDB.connection
      obj = connection.post("/tags/#{namespace}",:payload => options)
      new({:connection => connection, :namespace => namespace}.merge(options).merge(obj))
    end
    
    
    def initialize(options = {}) #:nodoc:
      @options = options
      @options[:connection] ||= FluidDB.connection
      if @options[:path]
        path = @options[:path].split('/')
        @options[:namespace] = path[0..-2].join('/')
        @options[:name] = path.last
      end
    end
    
    
    # Return an FluidDB::Tag
    #
    #   FluidDB::Tag.get("test/opionion")  => #<FluidDB::Tag>
    #
    # If the object can't be found it raises FluidDB::Error
    #
    # Params:
    # __returnDescription__:: Optional. it could be true or false
    # __connection__ Optional server
    def self.get(path,options = {})
      connection = options.delete(:connection) || FluidDB.connection
      obj = connection.get("/tags/#{path}",:query => options)
      new({:connection => connection, :path => path}.merge(options).merge(obj))
    end
    
    # Remove a the tag
    def delete
      @options[:connection].delete("/tags/#{path}") && true
    end
      
    # Return the namespace for the tag
    def namespace
      @options[:namespace] ||= URI.parse(@options[:URI]).path.split('/')[0..-2].join('/')
    end
    
    # Return the name of the tag
    def name
      @options[:name] ||= URI.parse(@options[:URI]).split('/').last
    end
    
    # Return the path of the tag
    def path
      "#{namespace}/#{name}"
    end
    
    # Return the description of the tag. If the description is not loaded, it will raise an error
    def description
      @options[:description] or raise FluidDB::Error.new('You should get with option :returnDescription => true')
    end
      
    # Update the description of the tag.
    def description=(description)
      @options[:connection].put("/tags/#{path}",:payload => {:description => description})
      @options[:description] = description
    end
    
    # Return the tag object-id
    def id
      @options[:id]
    end
    
    # Return true or false if the tag is indexed
    def indexed?
      @options[:indexed]
    end 
  end
end