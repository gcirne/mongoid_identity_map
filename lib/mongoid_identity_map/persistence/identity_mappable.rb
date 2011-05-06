require "active_support/core_ext"

module MongoidIdentityMap
  module Persistence
    module IdentityMappable
      extend ActiveSupport::Concern

      included do
        alias_method_chain :remove, :identity_map
      end

      def remove_with_identity_map(options = {})
        IdentityMap.remove(self)
        self.remove_without_identity_map(options)
      end
    end
  end
end

module Mongoid::Persistence
  included do
    include MongoidIdentityMap::Persistence::IdentityMappable
  end
end
