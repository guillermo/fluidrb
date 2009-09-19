require File.dirname(__FILE__) + '/../lib/fluiddb'

FluidDB.connect(:test)


def generate_uniq(data=nil)
  "fluidrb:#{`who am i`.split.first}:" + Time.now.to_i.to_s + Time.now.usec.to_s + rand(9999999999999999999).to_s+data.to_s
end