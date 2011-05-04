module MongoidIdentityMap
  class Railtie < Rails::Railtie
    initializer "mongoid_identity_map.initializer" do |app|
      app.middleware.use MongoidIdentityMap::ClearMiddleware
    end
  end
end
