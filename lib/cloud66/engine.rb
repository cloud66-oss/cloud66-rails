module Cloud66
  class Engine < ::Rails::Engine
    isolate_namespace Cloud66

    initializer "cloud66.configuration" do |app|
      if Cloud66.configuration.engine_automount
        app.routes.append do
          constraints(ip: /127\.0\.0\.1|::1/) do
            mount Cloud66::Engine => Cloud66.configuration.engine_automount_endpoint
          end
        end
      end
    end
  end
end
