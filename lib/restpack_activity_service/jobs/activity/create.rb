require 'sidekiq'

module Jobs
  module Activities
    module Activity
      class Create
        include Sidekiq::Worker

        def perform(params)
          Commands::Activities::Activity::Create::run(params)
        end
      end
    end
  end
end
