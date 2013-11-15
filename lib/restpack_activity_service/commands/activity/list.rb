module Commands::Activities::Activity
  class List < RestPack::Service::Command
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
      scope = Models::Activities::Activity.all
      scope = scope.where(application_id: application_id)

      scope = scope.where(user_id: user_id) if user_id
      scope = scope.all_tags_csv(tags) if tags
      scope = scope.any_tags_csv(access, :access) if access
      scope = scope.search(query) if query

      Serializers::Activities::Activity.resource(inputs, scope)
    end
  end
end
