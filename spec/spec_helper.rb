require File.dirname(__FILE__) + '/../lib/fluiddb'

FluidDB.set_credentials('test','test','sandbox.fluidinfo.com')


def generate_uniq
  "fluidrb:#{`who am i`.split.first}:" + Time.now.to_i.to_s + Time.now.usec.to_s + rand(9999999999999999999).to_s
end