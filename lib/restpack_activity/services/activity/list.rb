module RestPack::Services::Activity
  class List < Mutations::Command
    required do
      integer :application_id
    end

    optional do
      integer :user_id
      integer :page
      integer :page_size
      string  :tags
      string  :access
      string  :query
    end

    def execute
      scope = RestPack::Models::Activity.all
      scope = scope.where(application_id: application_id)

      scope = scope.where(user_id: user_id) if user_id
      scope = scope.all_tags_csv(tags) if tags
      scope = scope.any_tags_csv(access, :access) if access
      scope = scope.search(query) if query

      RestPack::Serializers::ActivitySerializer.resource(inputs, scope)
    end
  end
end
