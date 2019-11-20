# frozen_string_literal: true

module Pollution
  class MeasurementsPresenter
    attr_reader :lat, :lng, :fields, :cached
    private :lat, :lng, :fields, :cached

    def initialize(lat:, lng:, fields:, cached: false)
      @lat = lat
      @lng = lng
      @fields = Array(fields).map(&:downcase)
      @cached = cached
    end

    def to_text
      measurement_entities_collection.sort_by_fields
                                     .filter_by_fields
                                     .map(&:to_s)
                                     .join('|')
    end

    private

    def measurement_entities_collection
      Pollution::MeasurementsCollection.new(build_measurement_entities, @fields)
    end

    def measurement_strategy
      return Airly::MeasurementsCached if cached

      Airly::Measurements
    end

    def build_measurement_entities
      @measurement_entities = measurement_strategy.new(lat: lat, lng: lng)
                                                  .entities
    end
  end
end
