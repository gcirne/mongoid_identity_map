require 'active_support/core_ext'
require 'mongoid/collection'

module MongoidIdentityMap
  module IdentityMappable
    extend ActiveSupport::Concern

    included do
      alias_method_chain :find_one, :identity_map
    end

    def find_one_with_identity_map(selector = {}, options = {})
      find_one_without_identity_map(selector, options)
    end
  end
end

Mongoid::Collection.send(:include, MongoidIdentityMap::IdentityMappable)
