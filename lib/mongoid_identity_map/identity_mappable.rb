require 'mongoid/collection'

module MongoidIdentityMap
  module IdentityMappable
    def self.included(base)
      base.class_eval do
        alias_method :find_one_without_identity_map, :find_one
        alias_method :find_one, :find_one_with_identity_map
      end
    end

    def find_one_with_identity_map(selector = {}, options = {})
      find_one_without_identity_map(selector, options)
    end
  end
end

Mongoid::Collection.send(:include, MongoidIdentityMap::IdentityMappable)
