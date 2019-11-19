# frozen_string_literal: true

module Pollution
  class MeasurementsPresenter
    attr_reader :lat, :lng, :fields

    def initialize(lat:, lng:, fields:)
      @lat = lat
      @lng = lng
      @fields = Array(fields).map(&:downcase)
    end

    def measurement_entities_collection
      Pollution::MeasurementsCollection.new(build_measurement_entities, @fields)
    end

    def to_text
      measurement_entities_collection.sort_by_fields
                                     .filter_by_fields
                                     .map(&:to_s)
                                     .join('|')
    end

    private

    def build_measurement_entities
      @measurement_entities = Airly::Measurements.new(lat: lat, lng: lng)
                                                 .entities
    end
  end
end
