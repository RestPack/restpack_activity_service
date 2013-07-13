module RestPack::Serializers
  class ActivitySerializer
    include RestPack::Serializer

    self.model_class = RestPack::Models::Activity
    self.key = :activities

    attributes :id, :application_id, :user_id, :title, :content, :latitude, :longitude,
               :tags, :access, :data, :href, :updated_at, :created_at
  end
end
