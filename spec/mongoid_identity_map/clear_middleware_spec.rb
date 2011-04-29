require "spec_helper"

describe MongoidIdentityMap::ClearMiddleware do
  before do
    @env = {}
    @app = stub("app").as_null_object
    @clear_middleware = MongoidIdentityMap::ClearMiddleware.new(@app)
  end
  
  it "should call app" do
    @app.should_receive(:call).with(@env)
    @clear_middleware.call(@env)
  end
  
  it "should clear identity map after call" do
    MongoidIdentityMap::CurrentThreadHash.should_receive(:clear)
    @clear_middleware.call(@env)
  end
end
