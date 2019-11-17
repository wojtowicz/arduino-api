module Pollution
  class MeasurementsPresenter
    attr_reader :lat, :lng, :fields

    def initialize(lat:, lng:, fields:)
      @lat = lat
      @lng = lng
      @fields = Array(fields).map(&:downcase)
    end

    def measurement_entities
      build_measurement_entities
      validate_fields
      filter_measurement_entities
      sort_measurement_entities
      @measurement_entities
    end

    def to_text
      measurement_entities.map{|m| m.to_s }.join('|')
    end

    private

    def build_measurement_entities
      @measurement_entities = Airly::Measurements.new(lat: lat, lng: lng).entities
    end

    def validate_fields
      not_found = (fields - @measurement_entities.map(&:name).map(&:downcase))
      raise "Wrong field" if not_found.present?
    end

    def filter_measurement_entities
      return if @fields.blank?
      @measurement_entities.select! do |measurement_entity|
        fields.include?(measurement_entity.name.downcase)
      end
    end

    def sort_measurement_entities
      @measurement_entities.sort_by!{|x| @fields.index x.name.downcase}
    end
  end
end
