
module FluidDB
  class << self
    @@connection = nil
    
    # Create a new *default* server connection
    #   FluidDB::Connection.new(:test) #will use the sandbox
    #   
    # Params:
    #  * :username 
    #  * :password
    #  * :server
    #  * :schema   # Could be 'http' or 'https'
    #  * :port  # Change default port (443 for https and 80 for http)
    def connect(*args)
      @@connection = FluidDB::Connection.new(*args)
    end
    
    # Returns the current connection
    def connection
      @@connection
    end
  end
end