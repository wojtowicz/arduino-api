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

    it 'returns file with measurements' do
      get :index, params: params, format: :text

      expect(response).to have_http_status(:ok)
      expect(response.body).to eq("DATA:1|12.73|75|71|1012.62|66.44|24.71\n")
    end

    context 'with fields param' do
      let(:params) do
        { lat: lat, lng: lng, fields: %w[airly_caqi pm25 pm10] }
      end

      it 'returns file with filtered and ordered measurements' do
        get :index, params: params, format: :text

        expect(response).to have_http_status(:ok)
        expect(response.body).to eq("DATA:1|75|71\n")
      end
    end
  end
end
