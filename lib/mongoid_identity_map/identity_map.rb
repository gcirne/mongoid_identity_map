module MongoidIdentityMap
  class IdentityMap

    class << self
      def set(key, model)
        thread_local_hash[key] = thread_local_hash.values.detect {|value| value == model} || model
      end

      def get(key)
        thread_local_hash[key]
      end

      def fetch(key)
        get(key) || set(key, yield)
      end

      def remove(model)
        thread_local_hash.delete_if {|key, value| value == model}
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
