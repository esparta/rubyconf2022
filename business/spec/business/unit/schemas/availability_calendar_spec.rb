# frozen_string_literal: true

RSpec.describe Business::Schemas::AvailabilityCalendar do
  subject(:availability) { described_class.(input) }

  context 'when input is invalid (Failure) because units is not an array' do
    let(:product_id) { SecureRandom.uuid }
    let(:option_id) { SecureRandom.alphanumeric }
    let(:local_date_start) { '2022-11-29' }
    let(:local_date_end) { '2022-12-01' }
    let(:local_date_start_as_date) { Date.parse(local_date_start) }
    let(:local_date_end_as_date) { Date.parse(local_date_end) }
    let(:units) do
      { 'id' => 'AABB', 'quantity' => 1 }
    end
    let(:input) do
      {
        'productId' => product_id,
        'optionId' => option_id,
        'localDateStart' => local_date_start,
        'localDateEnd' => local_date_end,
        'units' => units
      }
    end

    it { expect(availability).to be_failure }

    it do
      expect(availability.errors.to_h).to match(units: ['must be an array'])
    end

    it do
      expect(
        availability.to_h
      ).to match(
        productId: product_id,
        optionId: option_id,
        localDateStart: local_date_start_as_date,
        localDateEnd: local_date_end_as_date,
        units: { 'id' => 'AABB', 'quantity' => 1 }
      )
    end
  end

  context 'when input is invalid (Failure)' do
    let(:input) do
      {}
    end

    it { expect(availability).to be_failure }
    it { expect(availability.to_h).to eq({}) }

    it do
      expect(
        availability.errors.to_h
      ).to match(
        productId: ['is missing'],
        optionId: ['is missing'],
        localDateStart: ['is missing'],
        localDateEnd: ['is missing']
      )
    end
  end

  context 'when input is valid (Success)' do
    let(:product_id) { SecureRandom.uuid }
    let(:option_id) { SecureRandom.alphanumeric }
    let(:local_date_start) { '2022-11-29' }
    let(:local_date_end) { '2022-12-01' }
    let(:local_date_start_as_date) { Date.parse(local_date_start) }
    let(:local_date_end_as_date) { Date.parse(local_date_end) }
    let(:unit_id) { SecureRandom.uuid }
    let(:units) do
      [
        { 'id' => unit_id, 'quantity' => 1 }
      ]
    end
    let(:input) do
      {
        'productId' => product_id,
        'optionId' => option_id,
        'localDateStart' => local_date_start,
        'localDateEnd' => local_date_end,
        'units' => units
      }
    end

    it { expect(availability).to be_success }
    it { expect(availability.errors.to_h).to be_empty }

    it do
      expect(
        availability.to_h
      ).to match(
        productId: product_id,
        optionId: option_id,
        localDateStart: local_date_start_as_date,
        localDateEnd: local_date_end_as_date,
        units: [{ id: unit_id, quantity: 1 }]
      )
    end
  end
end
