# frozen_string_literal: true

RSpec.describe Business::Schemas::Units do
  subject(:units) { described_class.(input) }

  let(:input) do
    { 'id' => uuid, 'quantity' => quantity }
  end

  let(:uuid) { SecureRandom.uuid }

  context 'when schema is not valid (Failure) because qty is not integer' do
    let(:quantity) { 1.2 }

    it { expect(units).to be_failure }

    it do
      expect(units.to_h).to match(id: uuid, quantity: quantity)
    end

    it do
      expect(
        units.errors.to_h
      ).to match(quantity: ['must be an integer'])
    end
  end

  context 'when schema is not valid (Failure) because qty < 1' do
    let(:quantity) { 0 }

    it { expect(units).to be_failure }

    it do
      expect(units.to_h).to match(id: uuid, quantity: quantity)
    end

    it do
      expect(units.errors.to_h).to match(quantity: ['must be greater than 0'])
    end
  end

  context 'when schema is not valid (Failure) because id is absent' do
    let(:quantity) { 1 }
    let(:input) do
      { 'quantity' => quantity }
    end

    it { expect(units).to be_failure }
    it { expect(units.to_h).to match(quantity: quantity) }
    it { expect(units.errors.to_h).to match(id: ['is missing']) }
  end

  context 'when schema is not valid (Failure) because qty is absent' do
    let(:input) do
      { 'id' => uuid }
    end

    it { expect(units).to be_failure }
    it { expect(units.to_h).to match(id: uuid) }
    it { expect(units.errors.to_h).to match(quantity: ['is missing']) }
  end

  context 'when schema is valid (Success)' do
    let(:quantity) { 1 }

    it { expect(units).to be_success }
    it { expect(units.errors.to_h).to be_empty }

    it do
      expect(units.to_h).to match(id: uuid, quantity: quantity)
    end
  end
end
