# frozen_string_literal: true

module Business
  module Schemas
    # Business::Schemas::OptionalLocalDates is an schema we mean to validate
    # later on in contracts done with Dry::Validation
    OptionalLocalDates = Dry::Schema.JSON do
      optional(:localDateStart).value(Types::JSON::Date)
      optional(:localDateEnd).value(Types::JSON::Date)
    end
  end
end
