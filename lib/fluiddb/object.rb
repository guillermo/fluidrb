
module FluidDB
  
  # FluidDB Object
  class Object
    ID_FORMAT = /^[0-9a-f]{8}-[0-9a-f]{4}-4[0-9a-f]{3}-[89AB][0-9a-f]{3}-[0-9a-f]{12}$/i
    
    # Creates a new object.
    #
    #   FluidDB::Object.create(:about => 'my new wadus object')  => #<FluidDB::Object>
    #
    # Params:
    # __about__:: Optional about
    # __connection__:: Optional server
    def self.create(options = {})
      connection = options.delete(:connection) || FluidDB.connection
      obj = connection.post('/objects',{:payload => options})
      new(options.merge(obj))
    end
    
    # Return an FluidDB::Object
    #
    #   FluidDB::Object.get("6073550f-4125-4603-b3be-02b68d7b01e6")  => #<FluidDB::Object>
    #
    # If the object can't be found it raises FluidDB::Error
    #
    # __Params__:
    # __connection__ => Optional server
    def self.get(id,options={})
      obj = (options[:connection] || FluidDB.connection).get("/objects/#{id}")
      obj = { :value => obj } unless obj.is_a? Hash
      new(options.merge(obj).merge(:id=>id))
    end
    
    
    # Return current object id
    def id
      @options[:id]
    end
    
    # Return lazy loaded about
    def about
      @options[:about] ||= @options[:connection].get("/objects/#{@options[:id]}/fluiddb/about")
    end
    
    # Return lazy loaded tagpats
    def tag_paths
      @options[:connection].get("/objects/#{@options[:id]}")[:tagPaths]
    end
    
    # Write a tag to the current object
    def write_tag(tag,value = nil)
      @options[:connection].put("/objects/#{@options[:id]}/#{tag}",:payload => value)
      value
    end
    
    # Return the value of a tag
    def read_tag(tag)
      @options[:connection].get("/objects/#{@options[:id]}/#{tag}")
    end
    
    # Remove the tag
    def remove_tag(tag)
      @options[:connection].delete("/objects/#{@options[:id]}/#{tag}")
    end
      
    # Check if the object has a tag
    def have_tag?(tag)
      @options[:connection].head("/objects/#{@options[:id]}/#{tag}")
      true
    rescue FluidDB::Error
      false
    end
    

    def initialize(options)  #:nodoc:
      @options = options
      @options[:connection] ||= FluidDB.connection
    end    
  end
end

