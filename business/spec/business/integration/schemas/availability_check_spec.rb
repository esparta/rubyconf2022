# frozen_string_literal: true

require 'dry/monads'

RSpec.describe Business::Schemas::AvailabilityCheck do
  subject(:availability) { described_class.(input) }

  let(:monad) do
    case availability.to_monad
    in Dry::Monads::Result::Success(productId:, optionId:)
      "<#{productId}>-<#{optionId}>"
    in Dry::Monads::Result::Failure(productId:, optionId:)
      'Something went wrong'
    end
  end

  context 'when input is valid (Success)' do
    let(:product_id) { SecureRandom.uuid }
    let(:option_id) { SecureRandom.alphanumeric }
    let(:input) do
      {
        'productId' => product_id,
        'optionId' => option_id
      }
    end

    it { expect(monad).to eq("<#{product_id}>-<#{option_id}>") }
  end

  context 'when input is not valid (Failure)' do
    let(:product_id) { SecureRandom.hex }
    let(:option_id) { SecureRandom.alphanumeric }
    let(:input) do
      {
        'productId' => product_id,
        'optionId' => option_id
      }
    end

    it { expect(monad).to eq('Something went wrong') }
  end
end
