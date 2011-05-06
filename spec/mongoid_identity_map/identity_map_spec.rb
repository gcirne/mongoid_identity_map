require "spec_helper"

describe MongoidIdentityMap::IdentityMap do
  let(:model) do
    Model.new(attributes)
  end
  
  let(:attributes) do
    {:_id => BSON::ObjectId("4da13240312f916cd2000002")}
  end
  
  let(:selector) do
    {:_id => BSON::ObjectId("4da13240312f916cd2000002")}
  end
  
  describe ".fetch" do
    let(:stub_model_find) do
      where = stub("where")
      Model.stub!(:where).with(selector).and_return(where)
      where.stub!(:first).and_return(model)
    end
    
    let(:fetch) do
      MongoidIdentityMap::IdentityMap.fetch(selector) do
        Model.where(selector).first
      end
    end

    context "when model doesn't exist in identity map" do
      before do
        MongoidIdentityMap::ThreadLocalHash.stub!(:get).with(selector).and_return(nil)
        stub_model_find
      end

      it "should return model" do
        where = stub("where")
        Model.should_receive(:where).with(selector).and_return(where)
        where.should_receive(:first).and_return(model)
        
        fetch.should be(model)
      end

      it "should set model in identity map" do
        MongoidIdentityMap::ThreadLocalHash.should_receive(:set).with(selector, model)
        fetch
      end
    end

    context "when model exists in identity map" do
      before do
        MongoidIdentityMap::ThreadLocalHash.stub!(:get).with(selector).and_return(model)
      end

      it "should return model" do
        fetch.should be(model)
      end

      it "should not call block" do
        Model.should_not_receive(:where)
        fetch
      end
    end
    
    context "when different instances of the same model exist in identity map more than once under different selectors" do
      let(:different_instance_of_the_same_model) do
        Model.new(attributes)
      end
      
      let(:different_selector) do
        selector.merge(:key => :value)
      end
      
      let(:stub_different_model_find) do
        different_where = stub("different_where")
        Model.stub!(:where).with(different_selector).and_return(different_where)
        different_where.stub!(:first).and_return(different_instance_of_the_same_model)
      end
      
      let(:fetch_with_different_selector) do
        MongoidIdentityMap::IdentityMap.fetch(different_selector) do
          Model.where(different_selector).first
        end
      end
      
      before :each do
        stub_model_find
        stub_different_model_find
      end
      
      it "should always return same model instance" do
        fetch
        fetch_with_different_selector.should be(model)
      end
    end
  end

  describe ".remove" do
    it "should remove model from identity map" do
      MongoidIdentityMap::ThreadLocalHash.should_receive(:remove).with(model)
      MongoidIdentityMap::IdentityMap.remove(model)
    end
  end

  describe ".clear" do
    it "should clear identity map" do
      MongoidIdentityMap::ThreadLocalHash.should_receive(:clear)
      MongoidIdentityMap::IdentityMap.clear
    end
  end
end
