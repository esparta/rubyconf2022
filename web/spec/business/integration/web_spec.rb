# frozen_string_literal: true

require 'rack/test'
require_relative '../../../business/web'

RSpec.describe Business::Web do
  include Rack::Test::Methods

  def app
    Business::Web.freeze.app
  end

  describe '/' do
    let(:path) { '/' }

    it do
      get path

      expect(last_response.status).to eq(200)
    end
  end

  describe '/api/v1/products/:id' do
    let(:id) { SecureRandom.uuid }
    let(:path) { "/api/v1/products/#{id}" }
    let(:json) { JSON.parse(last_response.body) }

    # Note we are using just one scenario, for a complete
    # test suite review the `Business::Api` gem located on `api` folder
    context 'when using an UUID (Success)' do
      let(:id) { SecureRandom.uuid }

      it do
        get path

        expect(last_response.status).to eq(200)
        expect(last_response.content_type).to eq('application/json')
        expect(json).to match('id' => id)
      end
    end
  end
end
