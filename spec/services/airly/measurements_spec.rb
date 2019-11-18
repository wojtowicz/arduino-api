# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Airly::Measurements do
  subject(:measurements) do
    described_class.new(lat: lat, lng: lng)
  end

  let(:lat) { '50.06143' }
  let(:lng) { '19.93658' }

  before do
    stub_request(
      :get,
      "#{Airly::ApiClient::API_URL}/v2/measurements/point"
    ).with(query: hash_including('lat' => lat, 'lng' => lng))
      .to_return(
        status: 200,
        body: fixture_json_data('airly_v2_measurements_point.json')
      )
  end

  describe '#entities' do
    subject(:entities) { measurements.entities }

    it 'returns entities' do
      expect(entities).to match_array(
        [
          have_attributes(class: Pollution::Entities::Measurement,
                          name: 'AIRLY_CAQI', value: 1,
                          limit: nil),
          have_attributes(class: Pollution::Entities::Measurement,
                          name: 'PM1', value: 12.73,
                          limit: nil),
          have_attributes(class: Pollution::Entities::Measurement,
                          name: 'PM25', value: 18.7,
                          limit: 25),
          have_attributes(class: Pollution::Entities::Measurement,
                          name: 'PM10', value: 35.53,
                          limit: 50),
          have_attributes(class: Pollution::Entities::Measurement,
                          name: 'PRESSURE', value: 1012.62,
                          limit: nil),
          have_attributes(class: Pollution::Entities::Measurement,
                          name: 'HUMIDITY', value: 66.44,
                          limit: nil),
          have_attributes(class: Pollution::Entities::Measurement,
                          name: 'TEMPERATURE', value: 24.71,
                          limit: nil)
        ]
      )
    end
  end
end
