require "sinatra"
require "sinatra/json"
require "sinatra/activerecord"
require "sidekiq"
require "dotenv"
require "pry"

class AdminInterface < Sinatra::Base
  Dotenv.load

  set :database, ENV['DATABASE_URL'] if ENV['DATABASE_URL']

  require_relative 'namely/company'
  require_relative 'namely/lockable_admin'
  require_relative 'lib/lockable_admin_parser'

  get '/companies' do
    companies = Company.all.map(&:to_json)
    json({
      meta: { count: Company.count },
      companies: companies
    })
  end

  #TODO update route name
  post '/companies' do
    data = JSON.parse request.body.read
    parser = AdminInterface::LockableAdminParser.new(data)
    begin
      parser.validate!
      AdminTasks::LockableAdmin.perform_async(
        parser.command,
        parser.permalinks,
        parser.emails,
        parser.authorized_by,
      )
      json success: true
    rescue AdminInterface::LockableAdminParser::InvalidPermalinks => message
      status 403
      return json permalink: message.to_s
    rescue AdminInterface::LockableAdminParser::TooRisky => message
      status 403
      return json error: message.to_s
    end
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
