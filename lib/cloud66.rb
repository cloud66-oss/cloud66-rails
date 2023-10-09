require "cloud66/version"
require "cloud66/engine"
require "cloud66/configuration"
require "cloud66/metrics"

module Cloud66
  class Error < StandardError; end
  class NotImplemented < Error; end

  def self.configuration
    @configuration ||= Cloud66::Configuration.new
  end

  def self.configure
    yield(configuration)
  end
end
