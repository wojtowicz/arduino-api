# frozen_string_literal: true

module Pollution
  module Airly
    class MeasurementsCached
      attr_reader :lat, :lng
      private :lat, :lng

      def initialize(lat:, lng:)
        @lat = lat
        @lng = lng
      end

      def entities
        Rails.cache.fetch(cache_name, expires_in: 2.minutes) do
          Measurements.new(lat: lat, lng: lng).entities
        end
      end

      private

      def cache_name
        "pollution/airly/measurements/#{lat}_#{lng}"
      end
    end
  end
end
