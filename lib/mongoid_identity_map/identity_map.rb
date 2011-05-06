module MongoidIdentityMap
  class IdentityMap

    class << self
      def fetch(selector)
        ThreadLocalHash.get(selector) || set_document_guaranteeing_same_instance(selector, yield)
      end

      def remove(document)
        ThreadLocalHash.remove(document)
      end

      def clear
        ThreadLocalHash.clear
      end
      
      private
      
      def set_document_guaranteeing_same_instance(selector, document)
        ThreadLocalHash.set(selector, ThreadLocalHash.values.detect {|value| value == document} || document)
      end
    end
    
  end
end
