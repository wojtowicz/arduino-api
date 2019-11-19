# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Pollution::MeasurementsPresenter do
  subject(:presenter) do
    described_class.new(lat: lat, lng: lng, fields: fields)
  end

  let(:lat) { '50.06143' }
  let(:lng) { '19.93658' }
  let(:fields) { nil }

  before do
    stub_pollution_airly_measurements_point
  end

  describe '#to_text' do
    subject { presenter.to_text }

    it { is_expected.to eq('1|12.73|75|71|1012.62|66.44|24.71') }

    context 'with fields' do
      let(:fields) { %w[airly_caqi pm25 pm10] }

      it { is_expected.to eq('1|75|71') }
    end
  end
end
