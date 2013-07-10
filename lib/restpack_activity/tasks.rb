module RestPack::Activity
  class Tasks
    def self.load_tasks
      load "restpack_activity/tasks/db.rake"
    end
  end
end
