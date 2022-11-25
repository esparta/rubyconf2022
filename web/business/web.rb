# frozen_string_literal: true

require 'roda'
require 'business/api'

module Business
  # Business::Web, entry point of our main web app
  # would mount other apps
  class Web < Roda
    route do |r|
      r.root do
        'Home'
      end
      r.on 'api' do
        r.run Business::Api.new
      end
    end
  end
end
