# test/services/projects/add_comment_test.rb

require 'test_helper'

class Projects::AddCommentTest < ActiveSupport::TestCase
  def setup
    @project = create(:project)
    @user = create(:user)
    @body = 'This is a new comment'
    @service = Projects::AddComment.new(project: @project, user: @user, body: @body)
  end

  test 'creates a comment with valid parameters' do
    assert_difference '@project.comments.count', 1 do
      @service.call
    end
  end

  test 'assigns the correct user to the comment' do
    comment = @service.call
    assert_equal @user, comment.user
  end

  test 'assigns the correct body to the comment' do
    comment = @service.call
    assert_equal @body, comment.body
  end

  test 'associates the comment with the correct project' do
    comment = @service.call
    assert_equal @project, comment.project
  end

  test 'raises error when body is missing' do
    invalid_service = Projects::AddComment.new(project: @project, user: @user, body: nil)
    assert_raises(ActiveRecord::RecordInvalid) do
      invalid_service.call
    end
  end
end
