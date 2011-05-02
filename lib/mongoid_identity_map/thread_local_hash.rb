module MongoidIdentityMap
  class ThreadLocalHash
    class << self
      def get(key)
        thread_local_hash[key]
      end
      
      def set(key, value)
        thread_local_hash[key] = value
      end
      
      def clear
        Thread.current[:mongoid_identity_map_current_thread_hash] = nil
      end
      
      private
      
      def thread_local_hash
        Thread.current[:mongoid_identity_map_current_thread_hash] ||= Hash.new
      end
    end
  end
end
