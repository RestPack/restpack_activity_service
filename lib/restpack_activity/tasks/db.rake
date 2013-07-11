namespace :restpack do
  desc "Run any outstanding RestPack migrations"
  task :migrate do
    Rake::Task["restpack:activity:migrate"].invoke
  end

  desc "List RestPack configuration"
  task :configuration do
    Rake::Task["restpack:activity:configuration"].invoke
  end

  namespace :activity do
    desc "Run any outstanding RestPack::Activity migrations"
    task :migrate => ["connection"] do
      source_migrations_path = File.dirname(__FILE__) + "/../../../db/migrate"
      target_migrations_path = "db/migrate"

      ActiveRecord::Migration.verbose = true
      ActiveRecord::Migrator.migrate(source_migrations_path)

      if File.directory?(target_migrations_path)
        FileUtils.cp_r(Dir["#{source_migrations_path}/*"], target_migrations_path)
      end
    end

    task :connection do
      ActiveRecord::Base.logger = Logger.new(STDOUT)
      config = YAML.load(IO.read('config/database.yml'))
      environment = ENV['RAILS_ENV'] || ENV['DB'] || 'development'
      ActiveRecord::Base.establish_connection config[environment]
    end

    desc "List RestPack::Activity configuration"
    task :configuration do
      p "RestPack::Activity Configuration"
      p "--------------------------------"
      p "database_table_prefix: #{RestPack::Activity.configuration.database_table_prefix}"
    end
  end
end
