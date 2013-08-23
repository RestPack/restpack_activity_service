require 'restpack_service/support/spec_helper'
require 'restpack_activity_service'

require_relative 'factories/activity_factory'

require 'coveralls'
Coveralls.wear!

config = YAML.load_file('./config/database.yml')
ActiveRecord::Base.establish_connection(ENV['DATABASE_URL'] || config['test'])

migrations_path = File.dirname(__FILE__) + "/../db/migrate"
migrator = ActiveRecord::Migrator.new(:up, migrations_path)
migrator.migrate

DatabaseCleaner.strategy = :transaction

RSpec.configure do |config|
  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end
end
