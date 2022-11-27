# frozen_string_literal: true

require_relative 'shared_examples_for_base_model'

RSpec.describe Business::Schemas::Product do
  it_behaves_like 'an schema based on BaseModel', 'Business::Schemas::Product'
end
