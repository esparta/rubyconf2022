# frozen_string_literal: true

RSpec.describe Business::Schemas::Product do
  it { expect(described_class).to be_a(Dry::Schema::Params) }
end
