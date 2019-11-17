module Pollution
  module Entities
    class Measurement
      attr_accessor :name, :value, :limit

      def initialize(name:, value:, limit:)
        @name = name
        @value = value
        @limit = limit || 1
      end

      def percentage_value
        (value / limit * 100).round
      end
    end
  end
end
