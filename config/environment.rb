Bundler.require(:default)
require 'dotenv'
require 'httparty'
require 'memoist'
require 'active_support/all'
require 'csv'
require 'thread/pool'
require 'byebug'

ROOT = File.expand_path('../../', __FILE__)
Dotenv.load
require "#{ ROOT }/lib/open_struct_parser"
require "#{ ROOT }/lib/skore_api"
require "#{ ROOT }/lib/reports"
