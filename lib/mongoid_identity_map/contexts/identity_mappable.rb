require "active_support/core_ext"

module MongoidIdentityMap
  module Contexts
    module IdentityMappable
      extend ActiveSupport::Concern
      
      included do
        alias_method_chain :one, :identity_map
        alias_method_chain :first, :identity_map
        alias_method_chain :last, :identity_map
      end
      
      def one_with_identity_map
        fetch(:one_without_identity_map)
      end

      def first_with_identity_map
        fetch(:first_without_identity_map)
      end

      def last_with_identity_map
        fetch(:last_without_identity_map)
      end

      private

      def fetch(method)
        IdentityMap.fetch(selector.merge(:_klass => klass)) do
          send(method)
        end
      end
    end
  end
end

Mongoid::Contexts::Mongo.send(:include, MongoidIdentityMap::Contexts::IdentityMappable)
