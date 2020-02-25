# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Device, type: :model do
  subject(:device) { described_class.new(name: 'Device 1', uuid: 'uuid1') }

  describe 'Validations' do
    it 'is valid with valid attributes' do
      expect(device).to be_valid
    end

    it 'is not valid without a uuid' do
      device.uuid = nil
      expect(device).not_to be_valid
    end

    it 'is not valid when uuid is not uniq' do
      create(:device, name: 'Device', uuid: 'exist_uuid')
      device.uuid = 'exist_uuid'
      expect(device).not_to be_valid
    end

    it 'is not valid without an name' do
      device.name = nil
      expect(device).not_to be_valid
    end
  end

  describe '#status' do
    subject { device.status }

    let(:sync_at) { nil }
    let(:wifi_ssid) { nil }
    let(:device) do
      create(:device,
             name: 'Device 1', uuid: 'uuid1', sync_at: sync_at,
             wifi_ssid: wifi_ssid)
    end

    it { is_expected.to eq('configuring') }

    context 'when sync_at is 30 second ago' do
      let(:sync_at) { 30.seconds.ago }

      it { is_expected.to eq('offline') }
    end

    context 'when sync_at is 30 second ago and wifi_ssid is present' do
      let(:sync_at) { 30.seconds.ago }
      let(:wifi_ssid) { 'WIFISSID' }

      it { is_expected.to eq('online') }
    end

    context 'when sync_at is 2 minutes ago' do
      let(:sync_at) { 2.minutes.ago }

      it { is_expected.to eq('offline') }
    end

    context 'when sync_at is 2 minutes ago and wifi_ssid is present' do
      let(:sync_at) { 2.minutes.ago }
      let(:wifi_ssid) { 'WIFISSID' }

      it { is_expected.to eq('offline') }
    end
  end

  describe '#pollution_configured?' do
    subject { device.pollution_configured? }

    let(:lat) { '34.554334' }
    let(:lng) { '67.64534' }
    let(:airly_api_key) { 'APIKEY' }
    let(:device) do
      described_class.new(lat: lat, lng: lng, airly_api_key: airly_api_key)
    end

    it { is_expected.to be_truthy }

    context 'when airly_api_key is missing' do
      let(:airly_api_key) { nil }

      it { is_expected.to be_falsey }
    end

    context 'when lat is missing' do
      let(:lat) { nil }

      it { is_expected.to be_falsey }
    end

    context 'when lng is missing' do
      let(:lng) { nil }

      it { is_expected.to be_falsey }
    end
  end
end
