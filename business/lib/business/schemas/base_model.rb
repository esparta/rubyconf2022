# frozen_string_literal: true

require 'dry/schema'
require 'dry/monads'

Dry::Schema.load_extensions(:monads)

module Business
  module Schemas
    # Business::Schemas::BaseModel contains the basic schema our
    # model will be based on.
    # As part of our business convention we decide that all our
    # persisted info will have an ID structured as a UUID v4.
    class BaseModel < Dry::Schema::Params
      define do
        required(:id).filled(:uuid_v4?)
      end
    end
  end
end
