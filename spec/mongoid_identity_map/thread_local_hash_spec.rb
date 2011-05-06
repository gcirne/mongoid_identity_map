require "spec_helper"

describe MongoidIdentityMap::ThreadLocalHash do
  describe "storing key value pairs" do
    it "should store key value pairs" do
      MongoidIdentityMap::ThreadLocalHash.set(:key, "value")
      
      Thread.new do
        MongoidIdentityMap::ThreadLocalHash.set(:key, "value2")
        MongoidIdentityMap::ThreadLocalHash.get(:key).should == "value2"
      end.join
      
      MongoidIdentityMap::ThreadLocalHash.get(:key).should == "value"
    end
  end

  describe ".remove" do
    it "should remove value" do
      MongoidIdentityMap::ThreadLocalHash.set(:key, "value")

      Thread.new do
        MongoidIdentityMap::ThreadLocalHash.set(:key, "value")
        MongoidIdentityMap::ThreadLocalHash.remove("value")
        MongoidIdentityMap::ThreadLocalHash.get(:key).should be_nil
      end.join

      MongoidIdentityMap::ThreadLocalHash.get(:key).should == "value"
    end
  end
  
  describe ".clear" do
    it "should clear" do
      MongoidIdentityMap::ThreadLocalHash.set(:key, "value")
      
      Thread.new do
        MongoidIdentityMap::ThreadLocalHash.set(:key, "value")
        MongoidIdentityMap::ThreadLocalHash.clear
        MongoidIdentityMap::ThreadLocalHash.get(:key).should be_nil
      end.join
      
      MongoidIdentityMap::ThreadLocalHash.get(:key).should == "value"
    end
  end
end
