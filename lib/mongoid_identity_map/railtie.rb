module MongoidIdentityMap
  class Railtie < Rails::Railtie
    initializer "mongoid_identity_map.initializer" do |app|
      app.middleware.use MongoidIdentityMap::ClearMiddleware unless Rails.env.test?
    end
  end
end
