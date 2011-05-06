require "spec_helper"

describe MongoidIdentityMap::Persistence::IdentityMappable do
  describe "#remove" do
    before do
      @model = Model.new
      @model.stub!(:remove_without_identity_map)
      MongoidIdentityMap::IdentityMap.stub!(:remove)
    end

    it "should remove document from identity map" do
      MongoidIdentityMap::IdentityMap.should_receive(:remove).with(@model)
      @model.remove
    end

    it "should remove document from database" do
      options = {:opt1 => :val1}
      @model.should_receive(:remove_without_identity_map).with(options)
      @model.remove(options)
    end
  end
end
