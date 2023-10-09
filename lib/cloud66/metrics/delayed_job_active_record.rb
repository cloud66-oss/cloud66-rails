require "cloud66/metrics/framework_base"

module Cloud66
  module Metrics
    class DelayedJobActiveRecord < FrameworkBase
      class << self
        protected

        def detected_concrete
          return ::Gem.loaded_specs["delayed_job"] &&
                 ::Gem.loaded_specs["delayed_job_active_record"] &&
                 ::Object.const_defined?(:Delayed) &&
                 ::Delayed.const_defined?(:Job) &&
                 ::Delayed.const_defined?(:Worker) &&
                 ::Delayed::Worker.respond_to?(:backend) &&
                 ::Delayed::Worker.backend = :active_record
        end

        def name_concrete
          return "delayed_job_active_record"
        end

        def queue_array_concrete
          delayed_job_pending = ::Delayed::Job.where(failed_at: nil, locked_at: nil).group(:queue).count
          delayed_job_working = ::Delayed::Job.where(failed_at: nil).where.not(locked_at: nil).group(:queue).count

          result = []
          delayed_job_queue_names = delayed_job_pending.keys | delayed_job_working.keys
          delayed_job_queue_names.each do |queue_name|
            result << {
              "backend" => name,
              "queue" => queue_name,
              "waiting" => delayed_job_pending[queue_name] || 0,
              "processing" => delayed_job_working[queue_name] || 0,
            }
          end

          return result
        end
      end
    end
  end
end
