# frozen_string_literal: true

module Business
  module Schemas
    # Business::Schemas::AvailabilityCheck
    # our schema matching the specs the Octo Travel API
    # https://docs.octo.travel/docs/octo/5b08f5f75e75d-availability-check
    # Note that `localDate`, `availabilityIds`, `localDateStart` and
    # `LocalDateEnd` are all optional, but you must suply at least
    # one of them. See more about that in the Contract we will
    # construct with them.
    #
    # This is one of the expected payloads:
    #
    # {
    #   "productId": "6b903d44-dc24-4ca4-ae71-6bde6c4f4854",
    #    "optionId": "DEFAULT",
    #    "localDateStart": "2022-05-23",
    #    "localDateEnd": "2022-05-29"
    # }
    AvailabilityCheck = Dry::Schema.JSON do
      required(:productId).filled(:uuid_v4?)
      required(:optionId).filled(:string)
      optional(:localDate).value(Types::JSON::Date)
      optional(:availabilityIds).array(:string)
      optional(:localDateStart).value(Types::JSON::Date)
      optional(:localDateEnd).value(Types::JSON::Date)
      optional(:units).array(Units)
    end
  end
end
