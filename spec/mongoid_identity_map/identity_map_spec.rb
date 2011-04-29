require "spec_helper"

describe MongoidIdentityMap::IdentityMap do
  before do
    @model = Model.new
    @selector = {:_id => BSON::ObjectId("4da13240312f916cd2000002")}
  end

  describe ".fetch" do
    context "when document doesn't exist in identity map" do
      before do
        Model.collection.stub!(:find_one_without_identity_map).with(@selector).and_return(@model)
      end

      it "should return document from database" do
        perform_fetch.should be(@model)
      end

      it "should set document in identity map" do
        perform_fetch
        MongoidIdentityMap::IdentityMap.send(:get, @selector).should be(@model)
      end
    end

    context "when document exists in identity map" do
      before do
        MongoidIdentityMap::IdentityMap.send(:set, {:_id => BSON::ObjectId("4da13240312f916cd2000002")}, @model)
      end

      it "should return document from identity map" do
        perform_fetch.should be(@model)
      end

      it "should not hit database" do
        Model.collection.should_not_receive(:find_one_without_identity_map)
        perform_fetch
      end
    end

    def perform_fetch
      MongoidIdentityMap::IdentityMap.fetch(@selector) do
        Model.collection.find_one_without_identity_map(@selector)
      end
    end
  end

  describe ".clear" do
    before do
      MongoidIdentityMap::IdentityMap.send(:set, @selector, @model)
      MongoidIdentityMap::IdentityMap.clear
    end

    it "should clear identity map" do
      MongoidIdentityMap::IdentityMap.send(:get, @selector).should be_nil
    end
  end
end
