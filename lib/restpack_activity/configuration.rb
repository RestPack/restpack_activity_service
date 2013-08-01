module RestPack::Activity
  class Configuration
    attr_accessor :database_table_prefix, :application_id

    def initialize
      @database_table_prefix = "restpack_"
      @application_id = 1
    end

    def prefix_table_name(name)
      "#{@database_table_prefix}#{name}".to_sym
    end
  end

  class << self
    attr_accessor :configuration
  end

  def self.configure
    self.configuration ||= Configuration.new
    yield configuration if block_given?
  end

  self.configure
end
