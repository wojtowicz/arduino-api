# frozen_string_literal: true

module Helpers
  def fixture_json_data(file_name)
    JSON.parse(file_fixture(file_name).read).to_json
  end

  def stub_pollution_airly_measurements_point
    stub_request(
      :get,
      "#{Pollution::Airly::ApiClient::API_URL}/v2/measurements/point"
    ).with(query: hash_including('lat' => lat, 'lng' => lng))
      .to_return(
        status: 200,
        body: fixture_json_data('airly_v2_measurements_point.json')
      )
  end
end
