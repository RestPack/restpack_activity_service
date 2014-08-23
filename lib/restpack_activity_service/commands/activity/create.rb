module Activity::Commands::Activity
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
      model   :data, class: Hash
    end

    def init
      if latitude.present? || longitude.present?
        if latitude.present? != longitude.present?
          service_error "Both Latitude and Longitude are required"
        end
      end

      #TEMP: GJ: some example service errors
      if title == "error"
        service_error "This is a service error"
      end

      if title == "custom"
        field_error :title, "Title should not be 'custom'"
      end
    end

    def execute
      model = Model.create!(inputs)
      Serializer.as_json(model)
    end
  end
end
