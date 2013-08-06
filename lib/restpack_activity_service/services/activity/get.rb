module RestPack::Services::Activity
  class Get < RestPack::Service::Command
    required do
      integer :id
      integer :application_id
    end

    def execute
      activity = RestPack::Models::Activity.find_by_id_and_application_id(
        inputs[:id],
        inputs[:application_id]
      )

      if activity
        RestPack::Serializers::ActivitySerializer.as_json(activity)
      else
        status :not_found
      end
    end
  end
end
