# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Pollution::Entities::Measurement do
  subject(:measurement) do
    described_class.new(name: name, value: value, limit: limit)
  end

  let(:name) { 'pm25' }
  let(:value) { 46 }
  let(:limit) { 25 }

  describe '#to_s' do
    subject { measurement.to_s }

    it { is_expected.to eq(184) }
  end
end
