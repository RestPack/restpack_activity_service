module Activity::Commands::Activity
  class List < RestPack::Service::Commands::List
    required do
      integer :application_id
    end

    optional do
      integer :user_id
      string  :tags
      string  :access
      string  :query
    end

    def scope
      scope = Model.all
      scope = scope.where(application_id: application_id)
      scope = scope.where(user_id: user_id) if user_id
      scope = scope.all_tags_csv(tags) if tags
      scope = scope.any_tags_csv(access, :access) if access
      scope = scope.search(query) if query
      scope
    end
  end
end
