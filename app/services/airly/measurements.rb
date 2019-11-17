module Airly
  class Measurements < ApiClient
    attr_reader :lat, :lng

    def initialize(lat:, lng:)
      @lat = lat
      @lng = lng
    end

    def entities
      build_entities
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
      raw_current_standards.find{|s| s['pollutant'] == measurement_name }&.fetch('limit')
    end

    def filter_entities(entities)
      entities.select do |entity|
        AVAILABLE.include?(entity.name)
      end
    end
  end
end
