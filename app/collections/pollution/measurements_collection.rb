# frozen_string_literal: true

module Pollution
  class MeasurementsCollection
    attr_reader :data, :fields

    include Enumerable

    def initialize(data, fields)
      @data = data
      @fields = fields
      raise 'Wrong fields' if wrong_fields?
    end

    def each
      data.each do |item|
        yield item
      end
    end

    def sort_by_fields
      data.sort_by! { |item| fields.index(item.name.downcase) || fields.length }
      self
    end

    def filter_by_fields
      return self if fields.blank?

      data.select! do |measurement_entity|
        fields.include?(measurement_entity.name.downcase)
      end

      self
    end

    private

    def wrong_fields?
      (fields - data.map(&:name).map(&:downcase)).present?
    end
  end
end
