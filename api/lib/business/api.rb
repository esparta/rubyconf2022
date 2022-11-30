# frozen_string_literal: true

require 'business'
require 'dry/monads'
require 'hanami/api'

require_relative 'process_data_with_dates'

module Business
  # Business::Api is our main application receiving the request
  # and returning data as JSON
  class Api < Hanami::API
    include Dry::Monads[:result]

    scope :v1 do
      get 'products/:id' do
        result = Business::Contracts::Product.(
          params.slice(:id, :localDateStart, :localDateEnd)
        )
        case result.to_monad
        in Success(id:, localDateStart:, localDateEnd:)
          json(ProcessDataWithDates.call(id, localDateStart, localDateEnd)) # rubocop:disable Naming/VariableName
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
