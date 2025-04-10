# frozen_string_literal: true

require "test_helper"

class StatusChangeTest < ActiveSupport::TestCase
  test "is valid with different previous and new status" do
    status_change = build(:status_change, previous_status: "draft", new_status: "active")
    assert status_change.valid?
  end

  test "is invalid if previous and new status are the same" do
    status_change = build(:status_change, previous_status: "draft", new_status: "draft")
    assert_not status_change.valid?
    assert_includes status_change.errors[:new_status], "must be different from previous status"
  end

  test "is invalid without previous_status" do
    status_change = build(:status_change, previous_status: nil)
    assert_not status_change.valid?
    assert_includes status_change.errors[:previous_status], "can't be blank"
  end

  test "is invalid without new_status" do
    status_change = build(:status_change, new_status: nil)
    assert_not status_change.valid?
    assert_includes status_change.errors[:new_status], "can't be blank"
  end

  test "is invalid if status not in allowed STATUSES" do
    status_change = build(:status_change, new_status: "paused", previous_status: "draft")
    assert_not status_change.valid?
    assert_includes status_change.errors[:new_status], "is not included in the list"
  end
end
