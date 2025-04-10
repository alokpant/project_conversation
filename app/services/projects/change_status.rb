# frozen_string_literal: true

# Service class to change the status of a project and record the status change.
#
# This service updates the project's status and creates a record in the StatusChange
# model to track the change, including the user who initiated the change, the previous status,
# and the new status.
#
# @example:
#   project = Project.find(1)
#   user = User.find(1)
#   new_status = 'completed'
#   service = Projects::ChangeStatus.new(project: project, user: user, new_status: new_status)
#   service.call
# @returns [StatusChange] The created status change record.
module Projects
  class ChangeStatus
    def initialize(project:, user:, new_status:)
      @project = project
      @user = user
      @new_status = new_status
    end

    def call
      previous_status = @project.status
      @project.update!(status: @new_status)
      StatusChange.create!(project: @project, user: @user, previous_status: previous_status, new_status: @new_status)
    end
  end
end
