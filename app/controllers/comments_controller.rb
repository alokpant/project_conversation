# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @project = Project.find(params[:project_id])
    authorize! @project, to: :comment?

    @comment = @project.comments.build(comment_params.merge(user: current_user))

    if @comment.save
      # Update the project with the new comment
      respond_to do |format|
        format.turbo_stream { render turbo_stream: turbo_stream.append("comments-list", partial: "comments/comment", locals: { comment: @comment }) }
        format.html { redirect_to @project, notice: "Comment added." }
      end
    else
      # Re-render the form with errors
      render "projects/show", status: :unprocessable_entity, locals: { project: @project, comment: @comment }
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end
end
