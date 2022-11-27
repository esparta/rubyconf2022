# frozen_string_literal: true

RSpec.describe Business::Schemas::BaseModel do
  let(:payload) do
    { 'id' => uuid }
  end

  let(:result) { subject.call(payload) }

  context 'when having a Valid Schema' do
    let(:uuid) { SecureRandom.uuid }

    it { expect(result).to be_success }
    it { expect(result.to_h).to match(id: uuid) }

    context 'when used as monad' do
      it do
        monad = result.to_monad
        expect(monad).to be_a Dry::Monads::Result
        expect(monad.value!).to be(result)
      end
    end
  end

  context 'when having an Invalid schemas' do
    context 'when id is not a valid UUIDv4' do
      let(:uuid) { SecureRandom.hex }

      it do
        expect(result).to be_failure
        expect(result.errors.to_h).to match(id: ['is not a valid UUID'])
      end
    end

    context 'when id is empty' do
      let(:uuid) { '' }

      it do
        expect(result).to be_failure
        expect(result.errors.to_h).to match(id: ['must be filled'])
      end
    end

    context 'when having an empty payload' do
      let(:payload) do
        {}
      end

      it do
        expect(result).to be_failure
        expect(result.errors.to_h).to match(id: ['is missing'])
      end
    end
  end
end
