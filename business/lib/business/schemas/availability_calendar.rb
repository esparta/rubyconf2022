# frozen_string_literal: true

module Business
  module Schemas
    # Business::Schemas::AvailabilityCalendar
    # our schema matching the specs the Octo Travel API
    # https://docs.octo.travel/docs/octo/11e01f57f9cb0-availability-calendar
    # spec:
    # {
    #   'id' => { type: uuid, :required },
    #   'optionId' => { type: :string, :required },
    #   'localDateStart' => { type: string, format: yyyy-mm-dd, :required },
    #   'localDateEnd' => { type: string, format: yyyy-mm-dd, :required },
    #   'unitd' => [ # composed by Schemas::Units
    #      {
    #        'id' => { type: uuid, :required },
    #        'quantity' => { type: :integer, :required }
    #      }
    #   ]
    # }
    AvailabilityCalendar = Dry::Schema.JSON do
      required(:productId).filled(:uuid_v4?)
      required(:optionId).filled(:string)
      required(:localDateStart).value(Types::JSON::Date)
      required(:localDateEnd).value(Types::JSON::Date)
      optional(:units).array(Units)
    end
  end
end
