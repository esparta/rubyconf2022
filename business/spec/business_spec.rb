# frozen_string_literal: true

RSpec.describe Business do
  it 'has a version number' do
    expect(Business::VERSION).not_to be nil
  end
end
