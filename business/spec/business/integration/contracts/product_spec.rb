# frozen_string_literal: true

RSpec.describe Business::Contracts do
  subject(:class_with_monad) do
    class described_class::Example
      include Dry::Monads[:result]

      def call(input)
        contract = Business::Contracts::Product.call(input)
        case contract.to_monad
        in Success(id:, localDateStart:, localDateEnd:)
          "Requesting Model<#{id}> : (#{localDateStart}..#{localDateEnd})"
        in Success(id:)
          "Requesting Model<#{id}>"
        in Failure(id:)
          "Something went wrong: #{contract.errors.to_h}"
        end
      end
    end
    described_class::Example
  end

  let(:uuid) { SecureRandom.uuid }

  context 'when using only :id' do
    let(:payload) do
      {
        'id' => uuid
      }
    end

    it do
      expect(
        class_with_monad.new.call(payload)
      ).to match(/Requesting Model<#{uuid}>/)
    end
  end

  context 'when using :id & :localDates' do
    let(:payload) do
      {
        'id' => uuid,
        'localDateStart' => '2022-11-29',
        'localDateEnd' => '2022-12-01'
      }
    end

    it do
      expect(
        class_with_monad.new.call(payload)
      ).to match(/Requesting Model<#{uuid}> : \(/)
    end
  end

  context 'when :id is not a valid UUID' do
    let(:payload) do
      {
        'id' => SecureRandom.hex,
        'localDateStart' => '2022-11-29',
        'localDateEnd' => '2022-12-01'
      }
    end

    it do
      expect(
        class_with_monad.new.call(payload)
      ).to match(/Something went wrong: {:id/)
    end
  end

  context 'when :localDateStart is not present' do
    let(:payload) do
      {
        'id' => uuid,
        'localDateEnd' => '2022-12-01'
      }
    end

    it do
      expect(
        class_with_monad.new.call(payload)
      ).to match(/Something went wrong: {:localDateEnd/)
    end
  end

  context 'when :localDateEnd is not present' do
    let(:payload) do
      {
        'id' => uuid,
        'localDateStart' => '2022-11-29'
      }
    end

    it do
      expect(
        class_with_monad.new.call(payload)
      ).to match(/Something went wrong: {:localDateStart/)
    end
  end

  context 'when :localDateStart is after :localDateEnd is not present' do
    let(:payload) do
      {
        'id' => uuid,
        'localDateStart' => '2022-12-01',
        'localDateEnd' => '2022-11-29'
      }
    end

    it do
      expect(
        class_with_monad.new.call(payload)
      ).to match(/Something went wrong: {:localDateEnd/)
    end
  end
end
