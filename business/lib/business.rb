# frozen_string_literal: true

require_relative 'business/version'

module Business
  class Error < StandardError; end
  # Your code goes here...
end

require_relative 'business/schemas'
require_relative 'business/contracts'
