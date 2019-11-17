module Pollution
  module Entities
    class Measurement
      attr_accessor :name, :value, :limit

      def initialize(name:, value:, limit:)
        @name = name
        @value = value
        @limit = limit
      end

      def to_s
        return value if limit.blank?
        (value / limit * 100).round
      end
    end
  end
end
