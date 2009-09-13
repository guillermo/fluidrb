

module FluidDB
  class Error < Exception #:nodoc:
    def self.new(info)
      info = "#{info[:errorCode]}: #{info[:errorClass]} at #{info[:path]}}" if info.is_a? Hash
      super(info)
    end
  end
  
end

      