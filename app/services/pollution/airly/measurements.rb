# frozen_string_literal: true

module Pollution
  module Airly
    class Measurements < ApiClient
      attr_reader :lat, :lng

      LEVELS_MAP = {
        'VERY_LOW' => 1,
        'LOW' => 1,
        'MEDIUM' => 2,
        'HIGH' => 3,
        'VERY_HIGH' => 3,
        'EXTREME' => 3,
        'AIRMAGEDDON' => 3
      }.freeze

      def initialize(lat:, lng:)
        @lat = lat
        @lng = lng
      end

      def entities
        @entities = [build_level_entity].compact
        @entities.concat build_entities
        @entities
      end

      private

      def raw_results
        get('v2/measurements/point', query: { lat: lat, lng: lng }).body
      end

      def raw_current
        @raw_current ||= JSON.parse(raw_results)['current']
      end

      def raw_current_values
        @raw_current_values ||= raw_current['values']
      end

      def raw_current_standards
        @raw_current_standards ||= raw_current['standards']
      end

      def raw_current_indexes
        @raw_current_indexes ||= raw_current['indexes']
      end

      def build_level_entity
        raw_level = raw_current_indexes.find { |i| i['name'] == 'AIRLY_CAQI' }
        return if raw_level.blank?

        Pollution::Entities::Measurement.new(
          name: raw_level['name'],
          value: LEVELS_MAP[raw_level['level']],
          limit: nil
        )
      end

      def build_entities
        raw_current_values.map do |value|
          Pollution::Entities::Measurement.new(
            name: value['name'],
            value: value['value'],
            limit: limit_for(value['name'])
          )
        end
      end

      def limit_for(measurement_name)
        raw_current_standards.find { |s| s['pollutant'] == measurement_name }
                            &.fetch('limit')
      end
    end
  end
end
