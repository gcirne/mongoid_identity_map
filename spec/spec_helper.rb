require "mongoid_identity_map"
require "mongoid"
require "support/model"

RSpec.configure do |config|
  config.before(:each) do
    MongoidIdentityMap::IdentityMap.clear
  end
end
