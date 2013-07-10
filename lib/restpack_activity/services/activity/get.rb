module RestPack::Services::Activity
  class Get < Mutations::Command
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
        add_error(:id, :not_found, "Not Found")
      end
    end
  end
end
