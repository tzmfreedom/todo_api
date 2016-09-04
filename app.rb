require 'grape'
require 'active_record'
require 'erb'

# database.ymlと同じにしたい
spec = YAML.load(ERB.new(File.read('config/database.yml')).result) || {}
environment = ENV['RACK_ENV'] || 'development'
ActiveRecord::Base.configurations = spec.stringify_keys
ActiveRecord::Base.establish_connection(environment.to_sym)

require './models/todo'
require './todo'


unless ENV['USERNAME'].nil?
  use Rack::Auth::Basic do |username, password|
    username == ENV['USERNAME'] && password == ENV['PASSWORD']
  end
end

if ENV['RACK_ENV'] != 'production'
  require 'pry'
end