module RestPack::Serializers
  class ActivitySerializer
    include RestPack::Serializer

    self.model_class = RestPack::Models::Activity
    self.key = :activities

    attributes :id, :application_id, :user_id, :title, :content, :coordinates,
               :tags, :access, :data, :href, :updated_at, :created_at

    def include_coordinates?
      @model.latitude && @model.longitude
    end

    def coordinates
      {
        latitude: @model.latitude.to_f,
        longitude: @model.longitude.to_f
      }
    end
  end
end
