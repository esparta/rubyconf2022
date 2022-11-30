# frozen_string_literal: true

require 'dry/validation'

Dry::Validation.load_extensions(:monads)

module Business
  # Business::Contracs
  # Our container for the Contracts we mean to have
  module Contracts
  end
end

require_relative 'contracts/product'
