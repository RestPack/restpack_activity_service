require_relative 'base'

module RestPack::Models
  class Activity < Base
    self.restpack_table_name :activities

    def self.search(query)
      conditions = <<-EOS
        search_vector @@ plainto_tsquery('english', ?)
      EOS

      where(conditions, query)
    end

    scope :any_tags, -> (tags) { where('tag_list && ARRAY[?]', tags) }
    scope :all_tags, -> (tags) { where('tag_list @> ARRAY[?]', tags) }

    scope :any_tags_csv, -> (tags_csv, namespace = '') do
      any_tags(parse_tags_csv(tags_csv, namespace))
    end
    scope :all_tags_csv, -> (tags_csv, namespace = '') do
      all_tags(parse_tags_csv(tags_csv, namespace))
    end

    def tags=(tags_csv)
      set_tags(tags_csv)
    end

    def tags
      get_tags
    end

    def access=(access_csv)
      set_tags(access_csv, :access)
    end

    def access
      get_tags(:access)
    end

    private

    def set_tags(tags_csv, namespace = '')
      tags_csv = tags_csv.delete('|')
      clear_tags(namespace)

      self.tag_list += self.class.parse_tags_csv(tags_csv, namespace)
      self.tag_list.uniq!
    end

    def clear_tags(namespace = '')
      self.tag_list = self.tag_list.reject {|tag| tag.start_with?("#{namespace}|")}
    end

    def get_tags(namespace = '')
      tags = self.tag_list.select {|tag| tag.start_with?("#{namespace}|")}
      tags.map {|tag| tag.gsub("#{namespace}|", '') }
    end

    def self.parse_tags_csv(tags_csv, namespace='')
      tags_csv.split(',').map {|tag| "#{namespace}|#{tag.strip}"}
    end
  end
end
