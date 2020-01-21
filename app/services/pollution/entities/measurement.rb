# frozen_string_literal: true

module Pollution
  module Entities
    class Measurement
      attr_accessor :name, :value, :limit

      def initialize(name:, value:, limit:)
        @name = name
        @value = value
        @limit = limit
      end

      def percentage
        return nil if limit.blank?

        (value.to_f / limit * 100).round
      end
    end
  end
end
