module Activity::Serializers
  class Activity
    include RestPack::Serializer

    self.model_class = ::Activity::Models::Activity
    self.key = :activities

    attributes :id, :application_id, :user_id, :title, :content, :latitude, :longitude,
               :tags, :access, :data, :href, :updated_at, :created_at
  end
end
