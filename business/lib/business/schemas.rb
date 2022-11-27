# frozen_string_literal: true

require 'dry/schema'
require 'dry/monads'

Dry::Schema.load_extensions(:monads)

module Business
  # Business::Schemas is the main container for the schemas used
  # in our application.
  module Schemas
  end
end

require_relative 'schemas/base_model'
require_relative 'schemas/product'
