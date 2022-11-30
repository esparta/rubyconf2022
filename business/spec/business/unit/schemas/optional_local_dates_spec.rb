# frozen_string_literal: true

RSpec.shared_examples 'a localDates result with expected output' do
  it { expect(local_dates).to be_success }
  it { expect(local_dates.errors.to_h).to be_empty }
  it { expect(local_dates.output).to match(output) }
end

RSpec.describe Business::Schemas::OptionalLocalDates do
  subject(:local_dates) { described_class.(input) }

  let(:local_date_start) { '2022-11-29' }
  let(:local_date_end) { '2022-12-01' }
  let(:local_date_start_as_date) { Date.parse(local_date_start) }
  let(:local_date_end_as_date) { Date.parse(local_date_end) }

  context 'when input has the wrong type' do
    context 'when localDateStart is not a date' do
      let(:input) do
        { 'localDateStart' => 12 }
      end

      it { expect(local_dates).to be_failure }

      it do
        expect(local_dates.errors.to_h).to match(
          localDateStart: ['must be a date']
        )
      end
    end

    context 'when localDateEnd is not a date' do
      let(:input) do
        { 'localDateEnd' => 12 }
      end

      it { expect(local_dates).to be_failure }

      it do
        expect(local_dates.errors.to_h).to match(
          localDateEnd: ['must be a date']
        )
      end
    end
  end

  context 'when input is empty (Sucess)' do
    let(:input) do
      {}
    end
    let(:output) do
      {}
    end

    it_behaves_like 'a localDates result with expected output'
  end

  context 'when input is not empty (Sucess, using localDateStart)' do
    let(:input) do
      { 'localDateStart' => local_date_start }
    end
    let(:output) do
      { localDateStart: local_date_start_as_date }
    end

    it_behaves_like 'a localDates result with expected output'
  end

  context 'when input is not empty (Sucess, using localDateEnd)' do
    let(:input) do
      {
        'localDateEnd' => local_date_end
      }
    end
    let(:output) do
      { localDateEnd: local_date_end_as_date }
    end

    it_behaves_like 'a localDates result with expected output'
  end

  context 'when input is not empty (Sucess, using localDateStart & localDateEnd)' do
    let(:input) do
      {
        'localDateStart' => local_date_start,
        'localDateEnd' => local_date_end
      }
    end
    let(:output) do
      {
        localDateStart: local_date_start_as_date,
        localDateEnd: local_date_end_as_date
      }
    end

    it_behaves_like 'a localDates result with expected output'
  end
end
