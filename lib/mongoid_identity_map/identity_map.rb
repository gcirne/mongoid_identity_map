module MongoidIdentityMap
  class IdentityMap
    @@hash = Hash.new

    class << self
      def fetch(key)
        get(key) || yield
      end

      private

      def get(key)
        @@hash[key]
      end
    end
  end
end
