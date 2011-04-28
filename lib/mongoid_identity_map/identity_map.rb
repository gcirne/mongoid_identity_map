module MongoidIdentityMap
  class IdentityMap
    @@hash = Hash.new

    class << self
      def fetch(selector)
        get(selector) || set(selector, yield)
      end

      def clear
        @@hash = Hash.new
      end

      private

      def get(selector)
        @@hash[selector]
      end

      def set(selector, document)
        @@hash[selector] = document
      end
    end
  end
end
