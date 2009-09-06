require File.join(File.dirname(__FILE__),'common.rb')  


FDB.set_credentials('test','test','sandbox.fluidinfo.com','https')

puts <<-EOPUTS
FDB is ready to work with the sandbox"

FDB / id

EOPUTS


