module FluidDB
  class Policy
    
    # Get a policy
    # You can also set options[:connection] to use a specific connection
    def self.get(policy,options = {})
      connection = options.delete(:connection) || FluidDB.connection
      new({:path => policy, :connection => connection}.merge(connection.get("/policies/#{policy}")))
    end
    
    def initialize(options = {}) #:nodoc:
      @options = options
    end
    
    # Update policy and exceptions
    def update(policy,exceptions)
      @options[:connection].put("/policies/#{@options[:path]}", :payload => {:exceptions => exceptions, :policy => policy}) && true
    end
    
    # Update a policy
    def policy=(new_policy)
      update(new_policy,exceptions)
      @options[:policy] = new_policy
    end
    
    # Return current policy
    def policy
      @options[:policy]
    end
    
    # Update exceptions 
    def exceptions=(new_exceptions)
      update(policy, new_exceptions)
      @options[:exceptions] = new_exceptions
    end
    
    # Returns current exceptions
    def exceptions
      @options[:exceptions]
    end
  end
end