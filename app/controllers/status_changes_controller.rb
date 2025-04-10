# frozen_string_literal: true

class StatusChangesController < ApplicationController
  before_action :authenticate_user!

  def create
    @project = Project.find(params[:project_id])
    authorize! @project, to: :update?

    @status_change = @project.status_changes.build(
      user: current_user,
      new_status: status_change_params[:new_status],
      previous_status: @project.status
    )

    if @status_change.save
      @project.update(status: @status_change.new_status)
      redirect_to @project, notice: "Status changed."
    else
      render "projects/show", status: :unprocessable_entity, locals: { status_change: @status_change }
    end
  end

  private

  def status_change_params
    params.require(:status_change).permit(:new_status)
  end
end
