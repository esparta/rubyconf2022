# frozen_string_literal: true

RSpec.shared_examples 'an availability schema with units' do |class_name|
  describe class_name.to_s do
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
          availability.output
        ).to match(
          productId: product_id,
          optionId: option_id,
          localDateStart: local_date_start_as_date,
          localDateEnd: local_date_end_as_date,
          units: { 'id' => 'AABB', 'quantity' => 1 }
        )
      end
    end
  end
end

RSpec.shared_examples 'an availability result with expected output' do
  it { expect(availability).to be_success }
  it { expect(availability.errors.to_h).to be_empty }
  it { expect(availability.output).to match(output) }
end
