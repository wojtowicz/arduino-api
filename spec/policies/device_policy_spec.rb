# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DevicePolicy, type: :policy do
  subject { described_class }

  let(:user) { nil }
  let(:lat) { '34.554334' }
  let(:lng) { '67.64534' }
  let(:device) { Device.new(lat: lat, lng: lng) }

  permissions :measurements? do
    it { is_expected.to permit(user, device) }

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
