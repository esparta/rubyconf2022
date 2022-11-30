# frozen_string_literal: true

require 'dry/validation'

module Business
  module Contracts
    # Business::Contracts::Product
    # Our Schema will be expanded to this
    # {
    #   'id' => { type: uuid_v4, :required },
    #   'localDateStart' => { type: :date, :optional, :coercible },
    #   'localDateEnd' => { type: :date, :optional, :coercible },
    # }
    Product = Dry::Validation::Contract.build do
      params(
        Business::Schemas::Product,
        Business::Schemas::OptionalLocalDates
      )

      # First rule: If you supply localDateStart, supply localDateEnd too
      rule(:localDateStart, :localDateEnd) do
        key.failure('must supply localDateEnd') if key?(:localDateStart) && !key?(:localDateEnd)
      end

      # Second rule: If you supply localDateEnd, supply localDateStart too
      rule(:localDateEnd, :localDateStart) do
        key.failure('must supply localDateStart') if key?(:localDateEnd) && !key?(:localDateStart)
      end

      # Third rule: localDateStart must be before localDateEnd
      rule(:localDateEnd, :localDateStart) do
        next unless key?(:localDateStart) && key?(:localDateEnd)

        key.failure('must be after localDateStart') if values[:localDateEnd] < values[:localDateStart]
      end
    end
  end
end
