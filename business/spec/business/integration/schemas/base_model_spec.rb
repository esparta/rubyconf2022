# frozen_string_literal: true

require 'dry/monads'
require 'business'

RSpec.describe Business::Schemas do
  subject do
    # Using our basic schema directly in a class and apply
    # pattern matching to the execution via to_monad
    class described_class::Example
      include Dry::Monads[:result]

      def call(input)
        case Business::Schemas::BaseModel.call(input).to_monad
        in Success(id:)
          "Requesting Model<#{id}>"
        in Failure(id:)
          "ID: #{id} not valid"
        end
      end
    end
    described_class::Example
  end

  let(:payload) do
    { 'id' => uuid }
  end

  context 'Success' do
    let(:uuid) do
      SecureRandom.uuid
    end
    it do
      expect(subject.new.call(payload)).to match(/Requesting Model<#{uuid}>/)
    end
  end

  context 'Failure' do
    let(:uuid) do
      SecureRandom.hex
    end
    it do
      expect(subject.new.call(payload)).to match(/ID: #{uuid} not valid/)
    end
  end
end
