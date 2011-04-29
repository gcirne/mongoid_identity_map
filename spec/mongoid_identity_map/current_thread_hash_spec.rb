require "spec_helper"

describe MongoidIdentityMap::CurrentThreadHash do
  describe ".set and .get" do
    it "should set and get key based value" do
      MongoidIdentityMap::CurrentThreadHash.set(:key, "value")
      
      Thread.new do
        MongoidIdentityMap::CurrentThreadHash.set(:key, "value2")
        MongoidIdentityMap::CurrentThreadHash.get(:key).should == "value2"
      end.join
      
      MongoidIdentityMap::CurrentThreadHash.get(:key).should == "value"
    end
  end
  
  describe ".clear" do
    it "should clear" do
      MongoidIdentityMap::CurrentThreadHash.set(:key, "value")
      
      Thread.new do
        MongoidIdentityMap::CurrentThreadHash.set(:key, "value")
        MongoidIdentityMap::CurrentThreadHash.clear
        MongoidIdentityMap::CurrentThreadHash.get(:key).should be_nil
      end.join
      
      MongoidIdentityMap::CurrentThreadHash.get(:key).should == "value"
    end
  end
end
