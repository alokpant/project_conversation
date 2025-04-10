# frozen_string_literal: true

require "test_helper"

class ProjectTest < ActiveSupport::TestCase
  test "is valid with valid attributes" do
    project = build(:project)
    assert project.valid?
  end

  test "is invalid without a title" do
    project = build(:project, title: nil)
    assert_not project.valid?
    assert_includes project.errors[:title], "can't be blank"
  end

  test "is invalid with too long title" do
    project = build(:project, title: "a" * 101)
    assert_not project.valid?
    assert_includes project.errors[:title], "is too long (maximum is 100 characters)"
  end

  test "is invalid without a status" do
    project = build(:project, status: nil)
    assert_not project.valid?
    assert_includes project.errors[:status], "can't be blank"
  end

  test "is invalid with a status not in STATUSES" do
    project = build(:project, status: "paused")
    assert_not project.valid?
    assert_includes project.errors[:status], "is not included in the list"
  end
end
