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
end
