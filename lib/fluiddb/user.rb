module FluidDB
  class User
    # Return an user by its username
    def self.get(username,options ={})
      connection = options.delete(:connection) || FluidDB.connection
      new( {:username => username}.merge( connection.get("/users/#{username}") ) )
    end
    
    # Return the username
    def username
      @options[:username]
    end
    
    # Return the name
    def name
      @options[:name]
    end
    
    # Return the id
    def id
      @options[:id]
    end
    
    def initialize(options) #:nodoc:
      @options = options
    end
    
  end
end