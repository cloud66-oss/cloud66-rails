require "cloud66/metrics/sidekiq"
require "cloud66/metrics/resque"
require "cloud66/metrics/delayed_job_active_record"

module Cloud66
  module Metrics
    class Manager
      QUEUE_FRAMEWORKS = [
        ::Cloud66::Metrics::Sidekiq,
        ::Cloud66::Metrics::Resque,
        ::Cloud66::Metrics::DelayedJobActiveRecord,
      ].freeze

      def self.metrics_array
        result = []
        QUEUE_FRAMEWORKS.each do |framework|
          next unless framework.detected?

          result += framework.queue_array
        end

        return result
      end
    end
  end
end
