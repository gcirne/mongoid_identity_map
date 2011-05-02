module MongoidIdentityMap
  class ClearMiddleware
    def initialize(app)
      @app = app
    end
    
    def call(env)
      res = @app.call(env)
      IdentityMap.clear
      res
    end
  end
end
