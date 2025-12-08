require "cloud66/metrics/framework_base"

module Cloud66
  module Metrics
    class SolidQueue < FrameworkBase
      class << self
        protected

        def detected_concrete
          ::Gem.loaded_specs.key?("solid_queue") &&
            ::Object.const_defined?(:SolidQueue) &&
            ::SolidQueue.const_defined?(:Job) &&
            ::SolidQueue.const_defined?(:ReadyExecution) &&
            ::SolidQueue.const_defined?(:ClaimedExecution) &&
            ::SolidQueue.const_defined?(:ScheduledExecution)
        end

        def name_concrete
          "solid_queue"
        end

        def queue_array_concrete
          # Get pending jobs per queue from ready executions
          solid_queue_pending = ::SolidQueue::ReadyExecution.group(:queue_name).count

          # Get due scheduled jobs per queue (scheduled_at <= now, not yet dispatched)
          # These should count as "waiting" for autoscaling purposes
          solid_queue_due_scheduled = ::SolidQueue::ScheduledExecution.due.group(:queue_name).count

          # Combine ready + due scheduled as total waiting
          solid_queue_waiting = solid_queue_pending.merge(solid_queue_due_scheduled) { |_key, ready, scheduled| ready + scheduled }

          # Get processing jobs per queue from claimed executions
          # Using Job.joins approach since queue_name is directly on Job
          solid_queue_working = ::SolidQueue::Job.joins(:claimed_execution).group(:queue_name).count

          result = []
          solid_queue_queue_names = solid_queue_waiting.keys | solid_queue_working.keys
          solid_queue_queue_names.each do |queue_name|
            result << {
              "backend" => name,
              "queue" => queue_name,
              "waiting" => solid_queue_waiting[queue_name] || 0,
              "processing" => solid_queue_working[queue_name] || 0,
            }
          end

          result
        end
      end
    end
  end
end
