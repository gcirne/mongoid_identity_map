module MongoidIdentityMap
  class CurrentThreadHash
    class << self
      def get(key)
        current_thread_hash[key]
      end
      
      def set(key, value)
        current_thread_hash[key] = value
      end
      
      def clear
        Thread.current[:mongoid_identity_map_current_thread_hash] = nil
      end
      
      private
      
      def current_thread_hash
        Thread.current[:mongoid_identity_map_current_thread_hash] ||= Hash.new
      end
    end
  end
end
