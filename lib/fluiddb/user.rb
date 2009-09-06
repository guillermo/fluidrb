module FluidDB
  class User < Resource
    def self.find(name)
      new(:path => '/users/'+name).fetch
    end
    
    def fetch
      get!
      self
    end
  end
end