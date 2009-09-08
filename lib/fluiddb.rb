$:.unshift File.dirname(__FILE__)
require 'rubygems'
require 'json'
require 'net/http'
require 'net/https'
require 'uri'
require 'mime/types'
require 'ostruct'


require 'fluiddb/version'
require 'fluiddb/connection'
require 'fluiddb/fluiddb'
require 'fluiddb/error'
require 'fluiddb/resource'

require 'fluiddb/object'
require 'fluiddb/user'
require 'fluiddb/tag'
require 'fluiddb/namespace'

