require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "user is valid" do
    user = User.new(email: "test@example.com", password_digest: "hashed_password")
    assert user.valid?
  end

  test "user is invalid without email" do
    user = User.new(email: nil, password_digest: "hashed_password")
    refute user.valid?
  end

  test "user is invalid without password_digest" do
    user = User.new(email: "test@example.com", password_digest: nil)
    refute user.valid?
  end

  test "user is invalid with invalid email" do
    user = User.new(email: "invalid_email", password_digest: "hashed_password")
    refute user.valid?
  end

  test "user with taken email should be invalid" do
    other_user = users(:one)
    user = User.new(email: other_user.email, password_digest: "hashed_password")
    refute user.valid?
    assert_equal "has already been taken", user.errors[:email].first
  end
end
