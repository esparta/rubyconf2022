# frozen_string_literal: true

RSpec.shared_examples 'an schema based on BaseModel' do |class_name|
  describe class_name.to_s do
    subject(:result) do
      described_class.call(payload)
    end

    let(:payload) do
      { 'id' => uuid }
    end

    context 'when having a Valid Schema' do
      let(:uuid) { SecureRandom.uuid }

      it { expect(result).to be_success }
      it { expect(result.output).to match(id: uuid) }
      it { expect(result.errors.to_h).to be_empty }

      context 'with extra keys, they will be ignored' do
        let(:payload) do
          {
            'id' => uuid,
            'extra' => 'will be ignored'
          }
        end

        it { expect(result).to be_success }
        it { expect(result.output).to match(id: uuid) }
        it { expect(result.errors.to_h).to be_empty }
      end

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

        it { expect(result).to be_failure }
        it { expect(result.errors.to_h).to match(id: ['is not a valid UUID']) }
        # Dear maintainer, this is the expected behavior, it always was.
        it { expect(result.output).to match(id: uuid) }
        # Even if the schema has errors, the data produced by `to_h` or `output`  will
        # include the "wrong" fields and their values are *not* `nil` either.
      end

      context 'when id is empty' do
        let(:uuid) { '' }

        it { expect(result).to be_failure }
        it { expect(result.errors.to_h).to match(id: ['must be filled']) }
        it { expect(result.output).to match(id: uuid) }
      end

      context 'when having an empty payload' do
        let(:payload) do
          {}
        end

        it { expect(result).to be_failure }
        it { expect(result.errors.to_h).to match(id: ['is missing']) }
        it { expect(result.output).to match({}) }
      end

      context 'when having extra keys, they will be ignored' do
        let(:payload) do
          { 'not_expected' => 'will_be_ignored' }
        end

        it { expect(result).to be_failure }
        it { expect(result.errors.to_h).to match(id: ['is missing']) }
        it { expect(result.output).to match({}) }
      end
    end
  end
end
