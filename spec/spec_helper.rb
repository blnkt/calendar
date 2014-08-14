require 'bundler/setup'

Bundler.require(:default, :test)

database_configurations = YAML::load(File.open('./db/config.yml'))
development_configuration = database_configurations['test']
ActiveRecord::Base.establish_connection(development_configuration)

Dir[File.dirname(__FILE__) + '/../lib/*.rb'].each { |file| require file }

RSpec.configure do |config|
  config.before(:each) do
    Event.all.each { |event| event.destroy }
  end
end
