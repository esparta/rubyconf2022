# frozen_string_literal: true

require 'dry/schema'

module Business
  module Schemas
    # Business::Schemas::Units - used to compose multiple other schemas
    # spec:
    #   { 'id' => { type: uuid_v4, :required },
    #     'quantity' => { type: integer, minValue: 1 }
    #   }
    Units = Dry::Schema.JSON(parent: BaseModel) do
      required(:quantity).value(:integer, gt?: 0)
    end
  end
end
