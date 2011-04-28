require 'spec_helper'

describe MongoidIdentityMap::IdentityMappable do
  describe "#find_one" do
    before do
      @model = Model.new
      Model.collection.stub!(:find_one_without_identity_map).with({:_id => BSON::ObjectId("4da13240312f916cd2000002")}, {}).and_return(@model)
    end

    it "should fetch document from identity map" do
      Model.collection.find_one({:_id => BSON::ObjectId("4da13240312f916cd2000002")}, {}).should be(@model)
    end
  end
end
