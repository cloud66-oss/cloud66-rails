module Cloud66
  class Configuration
    # Determines whether the engine is auto-mounted.
    attr_accessor :engine_automount
    # Determines the endpoint to which the engine is auto-mounted to.
    attr_accessor :engine_automount_endpoint

    def initialize
      self.engine_automount = true
      self.engine_automount_endpoint = "/cloud66"
    end
  end
end
