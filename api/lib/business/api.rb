# frozen_string_literal: true

require 'business'
require 'dry/monads'
require 'hanami/api'

module Business
  # Business::Api is our main application receiving the request
  # and returning data as JSON
  class Api < Hanami::API
    include Dry::Monads[:result]

    scope :v1 do
      get 'products/:id' do
        result = Business::Schemas::BaseModel.(params.slice(:id))
        case result.to_monad
        in Success(id:)
          json(id: id)
        in Failure(id:)
          status(400)
          json(reason: result.errors.to_h)
        end
      end
    end
  end
end
