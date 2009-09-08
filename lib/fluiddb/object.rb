
module FluidDB
  
  # FluidDB Object
  class Object
    
    ID_FORMAT = /^[0-9a-f]{8}-[0-9a-f]{4}-4[0-9a-f]{3}-[89AB][0-9a-f]{3}-[0-9a-f]{12}$/i
    
    # Creates a new object.
    # Params:
    #  * about => Optional about
    #  * connection => Optional server
    def self.create(options = {})
      obj = (options[:connection] || FluidDB.connection).post('/objects',{:payload => options})
      new(options.merge(obj))
    end
    
    def self.get(id,options={})
      obj = (options[:connection] || FluidDB.connection).get("/objects/#{id}")
      new(options.merge(obj))
    end
    
    def initialize(options)
      @options = options
      @options[:connection] ||= FluidDB.connection
    end
    
    def id
      @options[:id]
    end
    
    def about
      @options[:about] ||= @options[:connection].get("/objects/#{@objects[:id]}/fluiddb/about")
    end
    
    def tag_paths
      @options[:connection].get("/objects/#{@options[:id]}")[:tagPaths]
    end
      
    
    #         
    # # Create a new object.
    # # FluidDB::Object.create!
    # # FluidDB::Object.create!(:about => 'Cocacola')
    # def self.create!(opts = {})
    #   new(opts.merge(:path => '/objects')).post!(opts)
    # end
    # 
    # def self.find(query)      
    #   res = FluidDB.query(:get, "/objects", {}, {:query => query})[:ids] || []
    #   res.map{|o| self.new(:path => "/objects/#{o}")}
    # end
    # 
    # # Fetch the object from the server
    # def fetch
    #   merge_with_self(get!)
    #   self
    # end
    # 
    #     
    # # Return the value of a tag
    # # fluiddbobj / "user/opinion"  => 'Really nice'
    # def / (tag)
    #   Object.new(:path => self.path + "/"+tag ).value
    # end
    # 
    # # Simple form to fetch tags
    # # fluiddbobj.user.opinion.fetch! => 'Really nice'
    # # fluiddbobj.user.opinion = 'Not Really nice'
    # def method_missing(meth,*args)
    #   if meth.to_s =~ /=$/
    #     obj = Object.new(:path => self.path+"/"+ meth.to_s.gsub(/=$/,''))
    #     obj.update!(*args)
    #   else
    #     obj = (super || Object.new(:path => self.path+"/"+meth.to_s ))
    #   end
    #   obj
    # end
    # 
    # def value
    #   @table[:value] || fetch
    #   @table[:value]
    # end
    # 
    # # Update the value of a tag
    # def update!(value)
    #   put!({:value=>value})
    #   self
    # end
    # 
    # # Return an array of names that that object contains
    # def tags
    #   @table[:tagPaths] || fetch
    #   @table[:tagPaths].map do |tag|
    #     Object.new(:path => @table[:path]+'/'+tag)
    #   end
    # end
    # 
  end
end

