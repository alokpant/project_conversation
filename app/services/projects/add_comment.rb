# frozen_string_literal: true

# Service class to add a comment to a project.
# 
# This service is responsible for creating a new comment
# for a given project by a specific user with a body 
# provided by the user.
# @example:
#   project = Project.find(1)
#   user = User.find(1)
#   body = "This is a comment."
#   service = Projects::AddComment.new(project: project, user: user, body: body)
#   service.call
# @returns [Comment] The created comment object.
module Projects
  class AddComment
    def initialize(project:, user:, body:)
      @project = project
      @user = user
      @body = body
    end

    def call
      comment = @project.comments.create!(user: @user, body: @body)
      comment
    end
  end
end
