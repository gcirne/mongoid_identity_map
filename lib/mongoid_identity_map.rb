require "mongoid"

require "mongoid_identity_map/clear_middleware"
require "mongoid_identity_map/thread_local_hash"
require "mongoid_identity_map/identity_map"
require "mongoid_identity_map/identity_mappable"
require "mongoid_identity_map/railtie" if defined?(Rails)
require "mongoid_identity_map/persistence/identity_mappable"
