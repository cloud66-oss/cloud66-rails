require "cloud66/metrics/framework_base"

module Cloud66
  module Metrics
    class Sidekiq < FrameworkBase
      class << self
        protected

        def detected_concrete
          return ::Gem.loaded_specs.key?("sidekiq") &&
                 ::Object.const_defined?(:Sidekiq) &&
                 ::Sidekiq.const_defined?(:Queue) &&
                 ::Sidekiq.const_defined?(:WorkSet)
        end
        def name_concrete
          return "sidekiq"
        end

        def queue_array_concrete
          sidekiq_pending = ::Sidekiq::Queue.all.map { |q| [q.name, q.size] }.to_h

          sidekiq_working_array = ::Sidekiq::WorkSet.new.map { |_, _, work| work["queue"] }
          sidekiq_working = ::Hash.new(0).tap { |h| sidekiq_working_array.each { |queue| h[queue] += 1 } }

          result = []
          sidekiq_queue_names = sidekiq_pending.keys | sidekiq_working.keys
          sidekiq_queue_names.each do |queue_name|
            result << {
              "backend" => name,
              "queue" => queue_name,
              "waiting" => sidekiq_pending[queue_name] || 0,
              "processing" => sidekiq_working[queue_name] || 0,
            }
          end

          return result
        end
      end
    end
  end
end
