# frozen_string_literal: true

require 'bundler/setup'
require_relative 'business/api'

run Business::Api.new
