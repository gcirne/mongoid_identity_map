require "spec_helper"

describe MongoidIdentityMap::IdentityMap do
  before do
    @model = Model.new
    @selector = {:_id => BSON::ObjectId("4da13240312f916cd2000002")}
  end
  
  describe ".fetch" do
    let (:fetch) do
      MongoidIdentityMap::IdentityMap.fetch(@selector) do
        Model.collection.find_one_without_identity_map(@selector)
      end
    end

    context "when document doesn't exist in identity map" do
      before do
        MongoidIdentityMap::CurrentThreadHash.stub!(:get).with(@selector).and_return(nil)
        Model.collection.stub!(:find_one_without_identity_map).with(@selector).and_return(@model)
      end

      it "should return document from database" do
        Model.collection.should_receive(:find_one_without_identity_map).with(@selector).and_return(@model)
        fetch.should be(@model)
      end

      it "should set document in identity map" do
        MongoidIdentityMap::CurrentThreadHash.should_receive(:set).with(@selector, @model)
        fetch
      end
    end

    context "when document exists in identity map" do
      before do
        MongoidIdentityMap::CurrentThreadHash.stub!(:get).with(@selector).and_return(@model)
      end

      it "should return document from identity map" do
        fetch.should be(@model)
      end

      it "should not hit database" do
        Model.collection.should_not_receive(:find_one_without_identity_map)
        fetch
      end
    end
  end

  describe ".clear" do
    it "should clear identity map" do
      MongoidIdentityMap::CurrentThreadHash.should_receive(:clear)
      MongoidIdentityMap::IdentityMap.clear
    end
  end
end
