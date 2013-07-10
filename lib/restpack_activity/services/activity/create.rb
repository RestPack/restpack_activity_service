module RestPack::Services::Activity
  class Create < Mutations::Command
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

    def execute
      if raw_inputs[:data]
        inputs[:data] = raw_inputs[:data]
      end

      activity = RestPack::Models::Activity.create(inputs)

      RestPack::Serializers::ActivitySerializer.as_json(activity)
    end
  end
end
