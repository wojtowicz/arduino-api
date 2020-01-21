# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Pollution::Entities::Measurement do
  subject(:measurement) do
    described_class.new(name: name, value: value, limit: limit)
  end

  let(:name) { 'pm25' }
  let(:value) { 46 }
  let(:limit) { 25 }

  describe '#percentage' do
    subject { measurement.percentage }

    it { is_expected.to eq(184) }

    context 'when limit is nil' do
      let(:limit) { nil }

      it { is_expected.to eq(nil) }
    end
  end
end
