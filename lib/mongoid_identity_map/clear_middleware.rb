module MongoidIdentityMap
  class ClearMiddleware
    def initialize(app)
      @app = app
    end
    
    def call(env)
      @app.call(env)
      CurrentThreadHash.clear
    end
  end
end
