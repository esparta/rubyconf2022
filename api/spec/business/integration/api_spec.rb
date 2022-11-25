# frozen_string_literal: true

require 'rack/test'

OUTER_APP = Rack::Builder.parse_file('config.ru').first

RSpec.describe Business::Api do
  include Rack::Test::Methods

  def app
    OUTER_APP
  end

  let(:json) { JSON.parse(last_response.body) }

  describe '/products/:id' do
    let(:path) { "/v1/products/#{id}" }

    context 'when using an UUID (Success' do
      let(:id) { SecureRandom.uuid }

      it do
        get path

        expect(last_response.status).to eq(200)
        expect(json).to match('id' => id)
      end
    end

    context 'when not using a UUID (Failure)' do
      let(:id) { SecureRandom.random_number(100) }

      it do
        get path
        expect(last_response.status).to eq(400)
        expect(json).to match(
          'reason' => {
            'id' => [
              'is not a valid UUID'
            ]
          }
        )
      end
    end
  end
end
