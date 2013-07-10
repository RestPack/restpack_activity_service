module RestPack::Models
  class Base < ActiveRecord::Base
    self.abstract_class = true

    def self.restpack_table_name(name)
      self.table_name = RestPack::Activity.configuration.prefix_table_name(name)
    end
  end
end
