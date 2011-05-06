require "spec_helper"

describe MongoidIdentityMap::Mongo::IdentityMappable do
  let(:model) do
    Model.new
  end
  
  let(:model_attributes) do
    model.attributes
  end
  
  describe "#one" do
    let(:selector) do
      {}
    end
    
    before do
      Model.collection.stub!(:find_one).with(selector, {}).and_return(model_attributes)
    end
    
    it "should return model" do
      Model.where(selector).one.should == model
    end
    
    it "should fetch model from identity map" do
      MongoidIdentityMap::IdentityMap.should_receive(:fetch).with(selector.merge(:_klass => Model))
      Model.where(selector).one
    end
  end
  
  describe "#first" do
    let(:selector) do
      {:selector => :value}
    end
    
    before do
      Model.collection.stub!(:find_one).with(selector, {}).and_return(model_attributes)
    end
    
    it "should return model" do
      Model.where(selector).first.should == model
    end
    
    it "should fetch model from identity map" do
      MongoidIdentityMap::IdentityMap.should_receive(:fetch).with(selector.merge(:_klass => Model))
      Model.where(selector).first
    end
  end
end
