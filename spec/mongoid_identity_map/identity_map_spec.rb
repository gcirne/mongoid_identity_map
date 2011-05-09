require "spec_helper"

describe MongoidIdentityMap::IdentityMap do
  let(:model) {Model.new}
  let(:other_model) {Model.new}
  let(:key) {:key}
  let(:other_key) {:key2}

  describe "storage" do
    describe "in multiple threads" do
      let(:other_model) {Model.new}

      it "should keep each thread's storage separate" do
        MongoidIdentityMap::IdentityMap.set(:key, model)

        Thread.new do
          MongoidIdentityMap::IdentityMap.set(:key, other_model)
          MongoidIdentityMap::IdentityMap.get(:key).should == other_model
        end.join

        MongoidIdentityMap::IdentityMap.get(:key).should == model
      end
    end

    describe "when the same model is stored under different keys" do
      let(:same_model_different_instance) {Model.new(model.attributes)}

      it "should store the same instance of the model under the different keys" do
        MongoidIdentityMap::IdentityMap.set(:key, model)
        MongoidIdentityMap::IdentityMap.set(:key2, same_model_different_instance)
        MongoidIdentityMap::IdentityMap.get(:key).should be(model)
        MongoidIdentityMap::IdentityMap.get(:key2).should be(model)
      end
    end
  end

  describe ".fetch" do
    let(:fetch) do
      MongoidIdentityMap::IdentityMap.fetch(key) do
        Model.first
      end
    end

    before do
      Model.stub!(:first).and_return(model)
    end

    context "when model doesn't exist in identity map" do
      it "should store model in identity map" do
        fetch
        MongoidIdentityMap::IdentityMap.get(key).should be(model)
      end

      it "should return model" do
        fetch.should be(model)
      end
    end

    context "when model exists in identity map" do
      before do
        MongoidIdentityMap::IdentityMap.set(key, model)
      end

      it "should not yield block" do
        Model.should_not_receive(:first)
        fetch
      end

      it "should return model" do
        fetch.should be(model)
      end
    end
  end

  describe ".remove" do
    before do
      MongoidIdentityMap::IdentityMap.set(key, model)
    end

    it "should remove model from identity map" do
      MongoidIdentityMap::IdentityMap.remove(model)
      MongoidIdentityMap::IdentityMap.get(key).should be_nil
    end
  end

  describe ".clear" do
    before do
      MongoidIdentityMap::IdentityMap.set(key, model)
      MongoidIdentityMap::IdentityMap.set(other_key, other_model)
    end

    it "should clear identity map" do
      MongoidIdentityMap::IdentityMap.clear
      MongoidIdentityMap::IdentityMap.get(key).should be_nil
      MongoidIdentityMap::IdentityMap.get(other_key).should be_nil
    end
  end
end
