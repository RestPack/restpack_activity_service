require "standalone_migrations"

StandaloneMigrations::Tasks.load_tasks

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
      migrations_path = File.dirname(__FILE__) + "/../../../db/migrate"
      migrator = ActiveRecord::Migrator.new(:up, migrations_path)
      migrator.migrate

      Rake::Task["db:structure:dump"].invoke
    end

    task :connection do
      ActiveRecord::Base.logger = Logger.new(STDOUT)

      Rake::Task["standalone:connection"].invoke
    end

    desc "List RestPack::Activity configuration"
    task :configuration do
      p "RestPack::Activity Configuration"
      p "--------------------------------"
      p "database_table_prefix: #{RestPack::Activity.configuration.database_table_prefix}"
    end
  end
end
