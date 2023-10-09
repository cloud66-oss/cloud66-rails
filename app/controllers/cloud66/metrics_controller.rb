module Cloud66
  class MetricsController < ApplicationController
    def queue
      render json: ::Cloud66::Metrics::Manager.metrics_array
    end
  end
end
