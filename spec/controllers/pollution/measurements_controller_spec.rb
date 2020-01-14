# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Pollution::MeasurementsController, type: :controller do
  render_views

  let(:lat) { '50.06143' }
  let(:lng) { '19.93658' }

  before do
    stub_pollution_airly_measurements_point
  end

  describe 'GET index' do
    let(:params) { { lat: lat, lng: lng } }

    context 'when request format is text' do
      let(:request_format) { :text }

      it 'returns file with measurements' do
        get :index, params: params, format: request_format

        expect(response).to have_http_status(:ok)
        expect(response.body).to eq(
          'DATA:1|12.73|18.7|35.53|1012.62|66.44|24.71|75|71'
        )
        expect(response.headers.length).to eq(3)
        expect(response.headers).to eq(
          'Content-Length' => 49,
          'Content-Type' => 'text/plain',
          'Cache-Control' => 'private'
        )
      end
    end

    context 'when request format is text and with fields param' do
      let(:request_format) { :text }
      let(:params) do
        { lat: lat, lng: lng, fields: %w[airly_caqi pm25% pm10%] }
      end

      it 'returns file with filtered and ordered measurements' do
        get :index, params: params, format: request_format

        expect(response).to have_http_status(:ok)
        expect(response.body).to eq('DATA:1|75|71')
        expect(response.headers.length).to eq(3)
        expect(response.headers).to eq(
          'Content-Length' => 12,
          'Content-Type' => 'text/plain',
          'Cache-Control' => 'private'
        )
      end
    end

    context 'when request format is json' do
      let(:request_format) { :json }

      it 'returns measurements' do
        get :index, params: params, format: request_format
        expect(response).to have_http_status(:ok)
        expect(response.body).to be_json_eql(
          {
            "airly_caqi": 1,
            "pm1": 12.73,
            "pm10": 35.53,
            "pm10%": 71,
            "pm25": 18.7,
            "pm25%": 75,
            "pressure": 1012.62,
            "humidity": 66.44,
            "temperature": 24.71
          }.to_json
        )
        expect(response.headers.length).to eq(7)
      end
    end

    context 'when request format is json and with fields param' do
      let(:request_format) { :json }
      let(:params) do
        { lat: lat, lng: lng, fields: %w[airly_caqi pm25 pm10 pm25% pm10%] }
      end

      it 'returns filtered and ordered measurements' do
        get :index, params: params, format: request_format

        expect(response).to have_http_status(:ok)
        expect(response.body).to be_json_eql(
          {
            "airly_caqi": 1,
            "pm25": 18.7,
            "pm25%": 75,
            "pm10": 35.53,
            "pm10%": 71
          }.to_json
        )
        expect(response.headers.length).to eq(7)
      end
    end
  end
end
