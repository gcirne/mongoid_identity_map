require 'spec_helper'

describe MongoidIdentityMap::IdentityMappable do
  describe "#find_one" do
    context "when document doesn't exist in identity map" do
      before do
        @model = Model.new
        Model.collection.stub!(:find_one_without_identity_map).with({:_id => BSON::ObjectId("4da13240312f916cd2000002")}, {}).and_return(@model)
      end

      it "should set document in identity map" do
        pending
      end

      it "should return document from database" do
        Model.collection.find_one({:_id => BSON::ObjectId("4da13240312f916cd2000002")}, {}).should be(@model)
      end
    end

    context "when object exists in identity map"
  end
end
