require_relative 'factories/activity_factory'
require_relative 'support/mutations_matchers'

require 'rspec'
require 'database_cleaner'
require 'yaml'
require 'restpack_activity'

config = YAML.load_file('./db/config.yml')
ActiveRecord::Base.establish_connection(config['test'])

DatabaseCleaner.strategy = :transaction

RSpec.configure do |config|
  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end
end
