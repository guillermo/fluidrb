module FluidDB
  class User #:nodoc:
    def self.find(name)
      new(:path => '/users/'+name).fetch
    end
    
    def fetch
      get!
      self
    end
  end
end