module Cloud66
  module Metrics
    class FrameworkBase
      def self.detected?
        return @detected unless @detected.nil?
        @detected = detected_concrete
        return @detected
      end

      def self.name
        return name_concrete
      end

      def self.queue_array
        return queue_array_concrete
      end

      class << self
        protected

        def detected_concrete
          raise ::Cloud66::NotImplemented
        end

        def name_concrete
          raise ::Cloud66::NotImplemented
        end

        def queue_array_concrete
          raise ::Cloud66::NotImplemented
        end
      end
    end
  end
end
