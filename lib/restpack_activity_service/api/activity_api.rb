require 'sinatra'

module RestPack
  class ActivityApi < Sinatra::Base
    get "/.json" do
      render RestPack::Services::Activity::List.run(params, application_params)
    end

    get "/:id.json" do
      render RestPack::Services::Activity::Get.run(params, application_params)
    end

    post "/.json" do
      render RestPack::Services::Activity::Create.run(params, application_params)
    end

    put "/:id.json" do
      render RestPack::Services::Activity::Update.run(params, application_params)
    end

    delete "/:id.json" do
      render RestPack::Services::Activity::Destroy.run(params, application_params)
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
