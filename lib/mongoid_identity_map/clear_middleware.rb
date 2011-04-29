module MongoidIdentityMap
  class ClearMiddleware
    def initialize(app)
      @app = app
    end
    
    def call(env)
      res = @app.call(env)
      CurrentThreadHash.clear
      res
    end
  end
end
