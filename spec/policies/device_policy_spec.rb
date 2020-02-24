# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DevicePolicy, type: :policy do
  subject { described_class }

  let(:user) { nil }
  let(:lat) { '34.554334' }
  let(:lng) { '67.64534' }
  let(:airly_api_key) { 'APIKEY' }
  let(:device) { Device.new(lat: lat, lng: lng, airly_api_key: airly_api_key) }

  permissions :measurements? do
    it { is_expected.to permit(user, device) }

    context 'when airly_api_key is missing' do
      let(:airly_api_key) { nil }

      it { is_expected.not_to permit(user, device) }
    end

    context 'when lat is missing' do
      let(:lat) { nil }

      it { is_expected.not_to permit(user, device) }
    end

    context 'when lng is missing' do
      let(:lng) { nil }

      it { is_expected.not_to permit(user, device) }
    end
  end
end
