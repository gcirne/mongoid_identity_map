require "active_support/core_ext"

module MongoidIdentityMap
  module Contexts
    module IdentityMappable
      extend ActiveSupport::Concern
      
      included do
        alias_method_chain :one, :identity_map
        alias_method_chain :first, :identity_map
      end
      
      def one_with_identity_map
        IdentityMap.fetch(selector.merge(:_klass => klass)) do
          one_without_identity_map
        end
      end
      alias :first_with_identity_map :one_with_identity_map
      
    end
  end
end

Mongoid::Contexts::Mongo.send(:include, MongoidIdentityMap::Contexts::IdentityMappable)
