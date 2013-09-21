module RestPack::Activity::Service::Commands
  module Activity
    class Destroy < RestPack::Service::Command
      required do
        integer :id
        integer :application_id
      end

      def execute
        activity = Models::Activity.find_by_id_and_application_id(
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
end
