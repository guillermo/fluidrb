module FluidDB
  class User #:nodoc:
    def self.get(username,options ={})
      connection = options.delete(:connection) || FluidDB.connection
      new( {:username => username}.merge( connection.get("/users/#{username}") ) )
    end
    
    def username
      @options[:username]
    end
    
    def name
      @options[:name]
    end
    
    def id
      @options[:id]
    end
    
    def initialize(options) #:nodoc:
      @options = options
    end
    
  end
end