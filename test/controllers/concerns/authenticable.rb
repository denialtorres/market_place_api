require "test_helper"

class MockController
  include Authenticable
  attr_accessor :request

  def initialize
    mock_request = Struct.new(:headers)
    self.request = mock_request.new(header: {})
  end
end

class AuthenticableTest < ActiveSupport::TestCase
  setup do
    @user = users(:one)
    @authentication = MockController.new
  end

  test "should get user from Authorization token" do
    @authentication.request.headers["Authorization"] = JsonWebToken.encode(user_id: @user.id)
    assert_not_nil @authentication.current_user
    assert_equal @user.id, @authentication.current_user.id
  end

  test "should not get user from invalid Authorization token" do
    @authentication.request.headers["Authorization"] = "invalid_token"
    assert_nil @authentication.current_user
  end
end
