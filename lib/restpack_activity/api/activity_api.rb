require 'sinatra'

module RestPack
  class ActivityApi < Sinatra::Base
    get "/.json" do
      render RestPack::Services::Activity::List.run(params, application_params)
    end

    get "/:id.json" do
      render RestPack::Services::Activity::Get.run(params, application_params)
    end

    #TODO: the rest of rest

    private

    def application_params
      #TODO: application_id may come from a domain mapping
      {
        application_id: RestPack::Activity::configuration.application_id
      }
    end

    def render(response)
      #TODO: set headers and status

      #TODO: move this logic into response
      response.result[:errors] = response.errors
      response.result.to_json
    end
  end
end
