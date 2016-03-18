# http://stackoverflow.com/a/16948087/2197402

ENV['RACK_ENV'] = 'test'
ENV['DATABASE_URL'] = 'postgresql://localhost/namely_test'

require File.join(File.dirname(__FILE__), '..', '..', 'admin_interface')
require 'cucumber'
require 'capybara'
require 'capybara/cucumber'
require 'database_cleaner'
require 'factory_girl'
require 'json'
require 'rspec'
require 'sinatra'

# http://anthonyeden.com/2013/07/10/testing-rest-apis-with-cucumber-and-rack.html
require 'rack/test'
World(Rack::Test::Methods)

# https://github.com/rspec/rspec-core/issues/1480
require 'rspec/mocks'
World(RSpec::Mocks::ExampleMethods)

Around('@mocks') do |scenario, block|
  RSpec::Mocks.setup

  block.call

  begin
    RSpec::Mocks.verify
  ensure
    RSpec::Mocks.teardown
  end
end

def app
  AdminInterface
end

Capybara.app = app

# https://github.com/DatabaseCleaner/database_cleaner#stderr-is-being-flooded-when-using-postgres
ActiveRecord::Base.logger = Logger.new('/dev/null')

DatabaseCleaner.strategy = :truncation

FactoryGirl.definition_file_paths = %w[./spec/factories]
FactoryGirl.find_definitions

Around do |scenario, block|
  DatabaseCleaner.cleaning(&block)
end
