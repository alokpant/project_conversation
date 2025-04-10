require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "is valid with valid attributes" do
    user = build(:user)
    assert user.valid?
  end

  test "is invalid without an email" do
    user = build(:user, email: nil)
    assert_not user.valid?
    assert_includes user.errors[:email], "can't be blank"
  end

  test "is invalid with duplicate email (case insensitive)" do
    create(:user, email: "test@example.com")
    user = build(:user, email: "TEST@example.com")
    assert_not user.valid?
    assert_includes user.errors[:email], "has already been taken"
  end

  test "downcases and strips email before validation" do
    user = build(:user, email: "  TEST@Example.com ")
    user.validate
    assert_equal "test@example.com", user.email
  end
end
