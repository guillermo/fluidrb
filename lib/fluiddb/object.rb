
module FluidDB
  
  # FluidDB Object
  class Object < Resource
            
    # Create a new object.
    # FluidDB::Object.create!
    # FluidDB::Object.create!(:about => 'Cocacola')
    def self.create!(opts = {})
      new_object = new(opts.merge(:path => '/objects')).post!(opts)
    end
    
    def self.find(query)      
      res = FluidDB.query(:get, "/objects", {}, {:query => query})[:ids] || []
      res.map{|o| self.new(:path => "/objects/#{o}")}
    end
    
    # Fetch the object from the server
    def fetch
      merge_with_self(get!)
      self
    end
    
        
    # Return the value of a tag
    # fluiddbobj / "user/opinion"  => 'Really nice'
    def / (tag)
      Object.new(:path => self.path + "/"+tag ).value
    end
    
    # Simple form to fetch tags
    # fluiddbobj.user.opinion.fetch! => 'Really nice'
    # fluiddbobj.user.opinion = 'Not Really nice'
    def method_missing(meth,*args)
      if meth.to_s =~ /=$/
        obj = Object.new(:path => self.path+"/"+ meth.to_s.gsub(/=$/,''))
        obj.update!(*args)
      else
        obj = (super || Object.new(:path => self.path+"/"+meth.to_s ))
      end
      obj
    end
    
    def value
      @table[:value] || fetch
      @table[:value]
    end
    
    # Update the value of a tag
    def update!(value)
      put!({:value=>value})
      self
    end
    
    # Return an array of names that that object contains
    def tags
      fetch! if self.tagPaths.nil?
      self.tagPaths
    end
    
  end
end

