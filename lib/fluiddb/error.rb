

module FluidDB
  class Error < Exception
    def self.new(info)
      info = "#{info[:errorCode]}: #{info[:errorClass]} at #{info[:path]}}" if info.is_a? Hash
      super(info)
    end
    
    def self.check_errors(ret)
      raise FluidDB::Error.new(ret) if ret && ret[:errorCode]
    end
  end
  
end

      