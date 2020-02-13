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
    let(:device) do
      create(:device, name: 'Device 1', uuid: 'uuid1', sync_at: sync_at)
    end

    it { is_expected.to eq('configuring') }

    context 'when sync_at is less then current time by 1 minute' do
      let(:sync_at) { 30.seconds.ago }

      it { is_expected.to eq('online') }
    end

    context 'when sync_at is more then current time by 1 minute' do
      let(:sync_at) { 2.minutes.ago }

      it { is_expected.to eq('offline') }
    end
  end
end