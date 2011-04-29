require "spec_helper"

describe MongoidIdentityMap::ClearMiddleware do
  before do
    @env = {}
    @resp = stub("resp")
    @app = stub("app")
    @app.stub!(:call).with(@env).and_return(@resp)
    @clear_middleware = MongoidIdentityMap::ClearMiddleware.new(@app)
  end
  
  it "should return app response" do
    @clear_middleware.call(@env).should be(@resp)
  end
  
  it "should clear identity map" do
    MongoidIdentityMap::CurrentThreadHash.should_receive(:clear)
    @clear_middleware.call(@env)
  end
end
