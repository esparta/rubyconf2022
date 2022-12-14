# frozen_string_literal: true

require 'dry/schema'
require 'dry/monads'

Dry::Schema.load_extensions(:monads)
require_relative 'types'

module Business
  # Business::Schemas is the main container for the schemas used
  # in our application.
  module Schemas
  end
end

require_relative 'schemas/base_model'
require_relative 'schemas/product'
require_relative 'schemas/units'
require_relative 'schemas/availability_calendar'
require_relative 'schemas/availability_check'
require_relative 'schemas/optional_local_dates'
