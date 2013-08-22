require 'sinatra'

module RestPack::Activity::Service::Api
  class Activity < Sinatra::Base
    get "/.json" do
      render Commands::Activity::List.run(params, application_params(request))
    end

    get "/:id.json" do
      render Commands::Activity::Get.run(params, application_params(request))
    end

    post "/.json" do
      render Commands::Activity::Create.run(params, application_params(request))
    end

    put "/:id.json" do
      render Commands::Activity::Update.run(params, application_params(request))
    end

    delete "/:id.json" do
      render Commands::Activity::Destroy.run(params, application_params(request))
    end

    def application_params(request)
      {
        application_id: 1
      }
    end

    private

    def render(response)
      status response.code
      response.result[:errors] = response.errors
      response.result.to_json
    end
  end
end
