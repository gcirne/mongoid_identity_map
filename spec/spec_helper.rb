require "mongoid_identity_map"
require "mongoid"
require "support/model"

RSpec.configure do |config|
  config.filter_run :focus => true
  config.run_all_when_everything_filtered = true
  
  config.before(:each) do
    MongoidIdentityMap::IdentityMap.clear
  end
end
