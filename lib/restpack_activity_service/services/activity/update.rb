module RestPack::Services::Activity
  class Update < RestPack::Service
    required do
      integer :id
      integer :application_id
    end

    optional do
      string  :title, empty: true
      string  :content
      string  :tags, empty: true
      string  :access, empty: true
      float   :latitude
      float   :longitude
    end

    def init
      inputs[:data] = raw_inputs[:data] if raw_inputs[:data]
    end

    def execute
      activity = RestPack::Models::Activity.find_by_id_and_application_id(inputs[:id], inputs[:application_id])

      if activity
        activity.update_attributes(inputs)
        RestPack::Serializers::ActivitySerializer.as_json(activity)
      else
        status :not_found
      end
    end
  end
end
