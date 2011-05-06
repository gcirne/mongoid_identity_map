module MongoidIdentityMap
  class IdentityMap

    class << self
      def fetch(selector)
        ThreadLocalHash.get(selector) || ThreadLocalHash.set(selector, yield)
      end

      def remove(document)
        ThreadLocalHash.remove(document)
      end

      def clear
        ThreadLocalHash.clear
      end
    end
    
  end
end
