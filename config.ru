# This file is used by Rack-based servers to start the application.

require ::File.expand_path('../config/environment',  __FILE__)
run Rails.application

require 'rack'
require 'rack/cache'
require 'redis-rack-cache'

use Rack::Cache,
metastore:   ENV['REDIS_URL'] + '/metastore',
entitystore: ENV['REDIS_URL'] + '/entitystore'
