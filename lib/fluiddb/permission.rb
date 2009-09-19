
module FluidDB
  class Permission
    
    # Get the permissions for a given resource
    #
    #   FluidDB::Permission.get('/test', 'update')
    #
    def self.get(resource,options)
      action = options.delete(:action)
      connection = options.delete(:connection) || FluidDB.connection

      options = {:connection => connection, :path => resource, :resource => resource}
      new( options.merge( connection.get("/permissions/#{resource}", :query => {:action => action}))) 
    end
    
    def initialize(options) #:nodoc:
      @options = options
      @options[:connection] ||= FluidDB.connection      
    end
    
    # Return the current exceptions
    def exceptions
      @options[:exceptions]
    end
    
    # Return the current policy
    def policy
      @options[:policy]
    end
    
    def resource
      @options[:resource]
    end
    
    def update(action,exceptions, policy)
      payload = {:exceptions => exceptions, :policy => policy}
      @options[:connection].put("/permissions/#{resource}", :payload => payload, :query => {:action => action}) && true
    end
    
  end
end
