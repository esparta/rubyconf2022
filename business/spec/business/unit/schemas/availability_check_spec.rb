# frozen_string_literal: true

require_relative 'shared_for_availability_schemas'

RSpec.describe Business::Schemas::AvailabilityCheck do
  subject(:availability) { described_class.(input) }

  it_behaves_like 'an availability schema with units', 'Business::Schemas::AvailabilityCalendar'

  context 'when input is invalid (Failure)' do
    let(:input) do
      {}
    end

    it { expect(availability).to be_failure }
    it { expect(availability.output).to eq({}) }

    it do
      expect(
        availability.errors.to_h
      ).to match(productId: ['is missing'], optionId: ['is missing'])
    end
  end

  context 'when input is valid (Success)' do
    let(:product_id) { SecureRandom.uuid }
    let(:option_id) { SecureRandom.alphanumeric }

    let(:local_date_as_string) { '2022-11-01' }
    let(:local_date_as_date) { Date.parse(local_date_as_string) }

    let(:availability_id) { SecureRandom.uuid }

    context 'when it is Sucess(using minimal)' do
      let(:input) do
        {
          'productId' => product_id,
          'optionId' => option_id
        }
      end

      let(:output) do
        {
          productId: product_id,
          optionId: option_id
        }
      end

      it_behaves_like 'an availability result with expected output'
    end

    context 'when it is Success(using localDate)' do
      let(:input) do
        {
          'productId' => product_id,
          'optionId' => option_id,
          'localDate' => local_date_as_string
        }
      end

      let(:output) do
        {
          productId: product_id,
          optionId: option_id,
          localDate: local_date_as_date
        }
      end

      it_behaves_like 'an availability result with expected output'
    end

    context 'when it is Success(using localDateStart & localDateEnd)' do
      let(:input) do
        {
          'productId' => product_id,
          'optionId' => option_id,
          'localDateStart' => local_date_as_string,
          'localDateEnd' => local_date_as_string
        }
      end

      let(:output) do
        {
          productId: product_id,
          optionId: option_id,
          localDateStart: local_date_as_date,
          localDateEnd: local_date_as_date
        }
      end

      it_behaves_like 'an availability result with expected output'
    end

    context 'when it is Success(using availabilityIds)' do
      let(:input) do
        {
          'productId' => product_id,
          'optionId' => option_id,
          'availabilityIds' => [availability_id]
        }
      end

      let(:output) do
        {
          productId: product_id,
          optionId: option_id,
          availabilityIds: [availability_id]
        }
      end

      it_behaves_like 'an availability result with expected output'
    end

    context 'when it is Success(using localDate, localDateStart & localDateEnd)' do
      let(:input) do
        {
          'productId' => product_id,
          'optionId' => option_id,
          'localDate' => local_date_as_string,
          'localDateStart' => local_date_as_string,
          'localDateEnd' => local_date_as_string
        }
      end

      let(:output) do
        {
          productId: product_id,
          optionId: option_id,
          localDate: local_date_as_date,
          localDateStart: local_date_as_date,
          localDateEnd: local_date_as_date
        }
      end

      it_behaves_like 'an availability result with expected output'
    end

    context 'when it is Success(using localDate, localDateStart & localDateEnd, availabilyIds)' do
      let(:input) do
        {
          'productId' => product_id,
          'optionId' => option_id,
          'localDate' => local_date_as_string,
          'localDateStart' => local_date_as_string,
          'localDateEnd' => local_date_as_string,
          'availabilityIds' => [availability_id]
        }
      end

      let(:output) do
        {
          productId: product_id,
          optionId: option_id,
          localDate: local_date_as_date,
          localDateStart: local_date_as_date,
          localDateEnd: local_date_as_date,
          availabilityIds: [availability_id]
        }
      end

      it_behaves_like 'an availability result with expected output'
    end
  end
end
