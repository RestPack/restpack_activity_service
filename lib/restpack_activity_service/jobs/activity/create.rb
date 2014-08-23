require 'sidekiq'

#TODO: GJ: generate namespace and aliases
module Activity
  module Jobs
    module Activity
      class Create
        include Sidekiq::Worker

        def perform(params)
          Activity::Commands::Create::run(params)
        end
      end
    end
  end
end
