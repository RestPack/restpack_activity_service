require 'sinatra'

module RestPack::Activity::Service::Api
  class Activity < Sinatra::Base
    get "/.json" do
      render Commands::Activity::List.run(params, application_params)
    end

    get "/:id.json" do
      render Commands::Activity::Get.run(params, application_params)
    end

    post "/.json" do
      render Commands::Activity::Create.run(params, application_params)
    end

    put "/:id.json" do
      render Commands::Activity::Update.run(params, application_params)
    end

    delete "/:id.json" do
      render Commands::Activity::Destroy.run(params, application_params)
    end

    private

    def application_params
      #TODO: application_id may come from a domain mapping
      {
        application_id: 1
      }
    end

    def render(response)
      status response.code
      response.result[:errors] = response.errors
      response.result.to_json
    end
  end
end
