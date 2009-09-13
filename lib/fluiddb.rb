$:.unshift File.dirname(__FILE__)
require 'rubygems'
require 'yajl'
require 'net/http'
require 'net/https'
require 'uri'
require 'mime/types'
require 'ostruct'


require 'fluiddb/version'
require 'fluiddb/connection'
require 'fluiddb/fluiddb'
require 'fluiddb/error'

require 'fluiddb/object'
require 'fluiddb/user'
require 'fluiddb/tag'
require 'fluiddb/namespace'


# = FluidDB
# Ruby API for FLUID DB
#
# == Usage
#   FluidDB.connect(:test)
#   obj = FluidDB::Object.create(:about => 'wadus object')
#   tag = FluidDB::Tag.create('test',:name => 'opinion', :description => 'my opinion', :indexed => true)
#   obj.write_tag('test/opinion','I think is funny.')
#
module FluidDB
  
end