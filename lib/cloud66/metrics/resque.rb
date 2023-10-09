require "cloud66/metrics/framework_base"

module Cloud66
  module Metrics
    class Resque < FrameworkBase
      class << self
        protected

        def detected_concrete
          return ::Gem.loaded_specs.key?("resque") &&
                 ::Object.const_defined?(:Resque) &&
                 ::Resque.respond_to?(:queues) &&
                 ::Resque.respond_to?(:working) &&
                 ::Resque.respond_to?(:size)
        end

        def name_concrete
          return "resque"
        end

        def queue_array_concrete
          resque_pending = ::Resque.queues.map { |queue_name| [queue_name, ::Resque.size(queue_name)] }.to_h

          resque_working_array = ::Resque.working.map { |worker| worker.job["queue"] }.compact
          resque_working = ::Hash.new(0).tap { |h| resque_working_array.each { |queue| h[queue] += 1 } }

          result = []
          resque_queue_names = resque_pending.keys | resque_working.keys
          resque_queue_names.each do |queue_name|
            result << {
              "backend" => name,
              "queue" => queue_name,
              "waiting" => resque_pending[queue_name] || 0,
              "processing" => resque_working[queue_name] || 0,
            }
          end

          return result
        end
      end
    end
  end
end
