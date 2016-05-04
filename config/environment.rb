Bundler.require(:default)
require 'dotenv'
require 'httparty'
require 'memoist'
require 'byebug'
require 'active_support/all'

Dotenv.load
require File.expand_path('../../lib/open_struct_parser', __FILE__)
require File.expand_path('../../lib/skore_api', __FILE__)
require File.expand_path('../../lib/report', __FILE__)
