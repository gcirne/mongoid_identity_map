require "spec_helper"

describe MongoidIdentityMap::Contexts::IdentityMappable do
  let(:model) do
    Model.new
  end
  
  let(:model_attributes) do
    model.attributes
  end

  let(:selector) do
    {:selector => :value}
  end

  shared_examples_for "methods that return a single model" do
    before do
      Model.collection.stub!(:find_one).with(selector, options).and_return(model_attributes)
    end

    it "should fetch model from identity map under key comprised of find selector merged with model class" do
      MongoidIdentityMap::IdentityMap.should_receive(:fetch).with(selector.merge(:_klass => Model))
      find
    end

    it "should return model" do
      find.should == model
    end
  end
  
  describe "#one" do
    it_should_behave_like "methods that return a single model" do
      let(:find) {Model.where(selector).one}
      let(:options) {{}}
    end
  end
  
  describe "#first" do
    it_should_behave_like "methods that return a single model" do
      let(:find) {Model.where(selector).first}
      let(:options) {{}}
    end
  end

  describe "#last" do
    it_should_behave_like "methods that return a single model" do
      let(:find) {Model.where(selector).last}
      let(:options) {{:sort=>[[:_id, :desc]]}}
    end
  end
end
