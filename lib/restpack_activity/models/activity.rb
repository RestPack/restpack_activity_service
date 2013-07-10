module RestPack::Models
  class Activity < RestPack::Models::Taggable
    self.restpack_table_name :activities
    serialize :data, JSON

    def self.search(query)
      conditions = <<-EOS
        search_vector @@ plainto_tsquery('english', ?)
      EOS

      where(conditions, query)
    end
  end
end
