# frozen_string_literal: true

RSpec.shared_examples 'a valid Product contract with expected output' do
  it { expect(contract).to be_success }
  it { expect(contract.errors.to_h).to be_empty }
  it { expect(contract.to_h).to match(output) }
end

RSpec.describe Business::Contracts::Product do
  subject(:contract) { described_class.(payload) }

  let(:uuid) { SecureRandom.uuid }
  let(:local_date_start_as_string) { '2022-11-29' }
  let(:local_date_end_as_string) { '2022-12-01' }
  let(:local_date_start_as_date) { Date.parse(local_date_start_as_string) }
  let(:local_date_end_as_date) { Date.parse(local_date_end_as_string) }

  context 'when Failure if localDateStart and not supplies localDateEnd' do
    let(:payload) do
      {
        'id' => uuid,
        'localDateStart' => local_date_start_as_string
      }
    end

    let(:output) do
      {
        id: uuid,
        localDateStart: local_date_start_as_date
      }
    end

    it { expect(contract).to be_failure }
    it { expect(contract.errors.to_h).to match(localDateStart: ['must supply localDateEnd']) }
    it { expect(contract.to_h).to eq(output) }
  end

  context 'when Failure if localDateEnd was supplied but localDateStart did not' do
    let(:payload) do
      {
        'id' => uuid,
        'localDateEnd' => local_date_end_as_string
      }
    end

    let(:output) do
      {
        id: uuid,
        localDateEnd: local_date_end_as_date
      }
    end

    it { expect(contract).to be_failure }
    it { expect(contract.errors.to_h).to match(localDateEnd: ['must supply localDateStart']) }
    it { expect(contract.to_h).to eq(output) }
  end

  context 'when Failure if localDateStart is after localDateEnd' do
    let(:payload) do
      {
        'id' => uuid,
        'localDateStart' => local_date_end_as_string,
        'localDateEnd' => local_date_start_as_string
      }
    end

    let(:output) do
      {
        id: uuid,
        localDateStart: local_date_end_as_date,
        localDateEnd: local_date_start_as_date
      }
    end

    it { expect(contract).to be_failure }
    it { expect(contract.errors.to_h).to match(localDateEnd: ['must be after localDateStart']) }
    it { expect(contract.to_h).to eq(output) }
  end

  context 'when Failure because the payload is empty' do
    let(:payload) do
      {}
    end

    it { expect(contract).to be_failure }
    it { expect(contract.errors.to_h).to match(id: ['is missing']) }
    it { expect(contract.to_h).to eq({}) }
  end

  context 'when Failure because the payload is missing the required field' do
    let(:payload) do
      { 'unexpected' => 'key and value' }
    end

    it { expect(contract).to be_failure }
    it { expect(contract.errors.to_h).to match(id: ['is missing']) }
    it { expect(contract.to_h).to eq({}) }
  end

  context 'when Success with the required parameter(:id)' do
    let(:payload) do
      { 'id' => uuid }
    end
    let(:output) do
      { id: uuid }
    end

    it_behaves_like 'a valid Product contract with expected output'
  end

  context 'when Success with both params(:id, :localDates)' do
    let(:payload) do
      {
        'id' => uuid,
        'localDateStart' => local_date_start_as_string,
        'localDateEnd' => local_date_end_as_string
      }
    end
    let(:output) do
      {
        id: uuid,
        localDateStart: local_date_start_as_date,
        localDateEnd: local_date_end_as_date
      }
    end

    it_behaves_like 'a valid Product contract with expected output'
  end
end
