Cloud66::Engine.routes.draw do
  get "metrics/queue", to: "metrics#queue"
end
