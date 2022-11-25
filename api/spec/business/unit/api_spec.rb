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

    context 'when not using an UUID (Failure)' do
      let(:id) { SecureRandom.random_number(100) }

      it do
        body = [{ reason: { id: ['is not a valid UUID'] } }.to_json]

        expect(api).to match([400, content_type, body])
      end
    end
  end
end
