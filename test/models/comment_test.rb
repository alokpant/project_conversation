require "test_helper"

class CommentTest < ActiveSupport::TestCase
  test "is valid with valid attributes" do
    comment = build(:comment)
    assert comment.valid?
  end

  test "is invalid without body" do
    comment = build(:comment, body: nil)
    assert_not comment.valid?
    assert_includes comment.errors[:body], "can't be blank"
  end

  test "is invalid with body less than 2 characters" do
    comment = build(:comment, body: "a")
    assert_not comment.valid?
    assert_includes comment.errors[:body], "is too short (minimum is 2 characters)"
  end
end
