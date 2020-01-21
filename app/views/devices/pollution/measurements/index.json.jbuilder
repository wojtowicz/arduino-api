# frozen_string_literal: true

@presenter.measurements.each do |measurement|
  json.set! measurement.name.downcase, measurement.value
end
