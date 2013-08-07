module RestPack::Services::Activity
  class Create < RestPack::Service::Command
    required do
      integer :application_id
      integer :user_id
      string  :content
    end

    optional do
      string  :title, empty: true
      string  :tags, empty: true
      string  :access, empty: true
      float   :latitude
      float   :longitude
    end

    def init
      inputs[:data] = raw_inputs[:data] if raw_inputs[:data]

      if latitude.present? || longitude.present?
        if latitude.present? != longitude.present?
          service_error "Both Latitude and Longitude are required"
        end
      end

      if title == "error"
        service_error "This is a service error"
      end

      if title == "custom"
        field_error :title, "Title should not be 'custom'"
      end
    end

    def execute
      activity = RestPack::Activity::Service::Models::Activity.create(inputs)
      RestPack::Activity::Service::Serializers::ActivitySerializer.as_json(activity)
    end
  end
end
