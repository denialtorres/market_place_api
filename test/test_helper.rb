ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"

module ActiveSupport
  class TestCase
    def assert_json_response_is_paginated(json_response)
      assert_not_nil json_response.dig(:links, :first)
      assert_not_nil json_response.dig(:links, :last)
      assert_not_nil json_response.dig(:links, :prev)
      assert_not_nil json_response.dig(:links, :next)
    end

    # Run tests in parallel with specified workers
    parallelize(workers: :number_of_processors)

    # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
    fixtures :all

    # Add more helper methods to be used by all tests here...
  end
end
