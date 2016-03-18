# http://recipes.sinatrarb.com/p/testing/rspec

ENV['RACK_ENV'] = 'test'
ENV['DATABASE_URL'] = 'postgresql://localhost/namely_test'

require File.join(File.dirname(__FILE__), '..', 'admin_interface')
require 'database_cleaner'
require 'factory_girl'
require 'rack/test'
require 'rspec'

# https://github.com/DatabaseCleaner/database_cleaner#stderr-is-being-flooded-when-using-postgres
ActiveRecord::Base.logger = Logger.new('/dev/null')

RSpec.configure do |config|
  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end

  config.around(:each) do |example|
    DatabaseCleaner.cleaning do
      example.run
    end
  end
end

module RSpecMixin
  include Rack::Test::Methods
  def app() Sinatra::Application end
end

FactoryGirl.definition_file_paths = %w[./spec/factories]
FactoryGirl.find_definitions
