module Activity::Commands::Activity
  class Destroy < RestPack::Service::Command
    required do
      integer :id
      integer :application_id
    end

    def execute
      activity = Model.find_by_id_and_application_id(
        inputs[:id],
        inputs[:application_id]
      )

      if activity
        activity.destroy
        nil
      else
        status :not_found
      end
    end
  end
end
