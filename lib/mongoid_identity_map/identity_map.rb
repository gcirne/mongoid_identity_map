module MongoidIdentityMap
  class IdentityMap

    class << self
      def fetch(selector)
        CurrentThreadHash.get(selector) || CurrentThreadHash.set(selector, yield)
      end

      def clear
        CurrentThreadHash.clear
      end
    end
    
  end
end
