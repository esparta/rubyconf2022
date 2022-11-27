# frozen_string_literal: true

require 'dry/monads'
require 'date'

RSpec.describe Business::Schemas::AvailabilityCalendar do
  subject(:availability) { described_class.(input) }

  let(:monad) do
    case availability.to_monad
    in Dry::Monads::Result::Success(productId:, optionId:, **rest)
      date_start_in_usa = rest[:localDateStart].strftime('%m/%d/%Y')
      date_end_in_usa = rest[:localDateEnd].strftime('%m/%d/%Y')
      "<#{productId}>-<#{optionId}>-(#{date_start_in_usa}..#{date_end_in_usa})"
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
        'optionId' => option_id,
        'localDateStart' => '2022-11-29',
        'localDateEnd' => '2022-12-01'
      }
    end

    it do
      expect(
        monad
      ).to eq("<#{product_id}>-<#{option_id}>-(11/29/2022..12/01/2022)")
    end
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
