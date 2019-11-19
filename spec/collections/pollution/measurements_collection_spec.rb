# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Pollution::MeasurementsCollection do
  subject(:collection) do
    described_class.new(data, fields)
  end

  let(:entity1) do
    Pollution::Entities::Measurement.new(
      name: 'entity1', value: 23.56, limit: 15
    )
  end
  let(:entity2) do
    Pollution::Entities::Measurement.new(name: 'entity2', value: 30, limit: 60)
  end
  let(:entity3) do
    Pollution::Entities::Measurement.new(
      name: 'entity3', value: 12.0, limit: 12
    )
  end

  let(:data) { [entity1, entity2, entity3] }
  let(:fields) { [] }

  describe '#sort_by_fields' do
    subject { collection.sort_by_fields.to_a }

    it { is_expected.to eq([entity1, entity2, entity3]) }

    context 'with fields' do
      let(:fields) { %w[entity2 entity1] }

      it { is_expected.to eq([entity2, entity1, entity3]) }
    end
  end

  describe '#filter_by_fields' do
    subject { collection.filter_by_fields.to_a }

    it { is_expected.to eq([entity1, entity2, entity3]) }

    context 'with fields' do
      let(:fields) { %w[entity2 entity1] }

      it { is_expected.to eq([entity1, entity2]) }
    end
  end
end
