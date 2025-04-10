# test/services/projects/change_status_test.rb

require 'test_helper'

class Projects::ChangeStatusTest < ActiveSupport::TestCase
  def setup
    @project = create(:project)
    @user = create(:user)
    @new_status = 'completed'
    @service = Projects::ChangeStatus.new(project: @project, user: @user, new_status: @new_status)
  end

  test 'updates the project status' do
    assert_not_equal @new_status, @project.status
    @service.call
    assert_equal @new_status, @project.reload.status
  end

  test 'creates a status change record' do
    @project.update!(status: 'draft')

    assert_difference 'StatusChange.count', 1 do
      @service.call
    end

    status_change = StatusChange.last
    assert_equal @project, status_change.project
    assert_equal @user, status_change.user
    assert_equal 'draft', status_change.previous_status
    assert_equal @new_status, status_change.new_status
  end

  test 'raises error if project status update fails' do
    @service = Projects::ChangeStatus.new(
      project: @project,
      user: @user,
      new_status: @project.status # same status to trigger validation error
    )

    assert_raises(ActiveRecord::RecordInvalid) do
      @service.call
    end
  end
end
