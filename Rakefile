require "rspec/core/rake_task"
RSpec::Core::RakeTask.new("spec")

task default: :spec

task :environment do
  require 'grape'
  require './todo'
end

desc 'API Routes'
task routes: :environment do
  API::V1::Base.routes.each do |api|
    method = api.request_method.ljust(10)
    path = api.path.gsub(':version', api.version)
    puts "     #{method} #{path}"
  end
end

namespace :ridgepole do
  desc 'Apply database schema'
  task :apply do
    ridgepole('--apply', "--file #{schema_file}")
  end

  desc 'Export database schema'
  task :export do
    ridgepole('--export', "--output #{schema_file}")
  end

  private

  def schema_file
    'Schemafile'
  end

  def config_file
    'config/database.yml'
  end

  def ridgepole(*options)
    command = ['bundle exec ridgepole', "--config #{config_file}"]
    system [command + options].join(' ')
  end
end