# frozen_string_literal: true

RSpec.describe Business::Api do
  subject(:api) do
    described_class.new.call(request)
  end

  let(:request) do
    {
      'PATH_INFO' => path,
      'REQUEST_METHOD' => request_method
    }
  end

  let(:request_method) { 'GET' }

  let(:content_type) do
    { 'Content-Type' => 'application/json' }
  end

  describe '/v1/products/:id/' do
    let(:path) { "/v1/products/#{id}" }

    context 'when using an UUID (Success' do
      let(:id) { SecureRandom.uuid }

      it do
        body = [{ id: id }.to_json]
        expect(api).to match([200, content_type, body])
      end
    end

    # rubocop:disable RSpec/MultipleMemoizedHelpers
    context 'when using an UUID & parameters (Success)' do
      let(:request) do
        {
          'PATH_INFO' => path,
          'REQUEST_METHOD' => request_method,
          'QUERY_STRING' => query_string
        }
      end
      let(:query_string) do
        "localDateStart=#{date_start_as_string}&localDateEnd=#{date_end_as_string}"
      end
      let(:date_start_as_string) { '2022-11-29' }
      let(:date_end_as_string) { '2022-12-01' }
      let(:date_start_as_unix) do
        Date.parse(date_start_as_string).strftime('%s')
      end
      let(:date_end_as_unix) do
        Date.parse(date_end_as_string).strftime('%s')
      end

      let(:id) { SecureRandom.uuid }

      it do
        hash = {
          id: id,
          date_start: date_start_as_unix,
          date_end: date_end_as_unix
        }
        body = [hash.to_json]
        expect(api).to match([200, content_type, body])
      end
    end
    # rubocop:enable RSpec/MultipleMemoizedHelpers

    context 'when not using an UUID (Failure)' do
      let(:id) { SecureRandom.random_number(100) }

      it do
        body = [{ reason: { id: ['is not a valid UUID'] } }.to_json]

        expect(api).to match([400, content_type, body])
      end
    end
  end
end
