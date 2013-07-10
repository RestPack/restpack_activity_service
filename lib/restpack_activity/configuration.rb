module RestPack::Activity
  class Configuration
    attr_accessor :database_table_prefix

    def initialize
      @database_table_prefix = "restpack_"
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
