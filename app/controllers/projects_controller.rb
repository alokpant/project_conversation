# frozen_string_literal: true

class ProjectsController < ApplicationController
  before_action :authenticate_user!
  # before_action :set_project, only: %i[show edit update destroy update_status]
  before_action :set_project, only: %i[show edit update destroy]

  def index
    @projects = current_user.projects.includes(:comments, :status_changes)
  end

  def show
    authorize! @project
    @comment = Comment.new
  end

  def new
    @project = current_user.projects.build
    authorize! @project, to: :create?
  end

  def create
    @project = current_user.projects.build(project_params)
    authorize! @project, to: :create?

    if @project.save
      redirect_to @project, notice: "Project created successfully."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    authorize! @project, to: :update?
  end

  def update
    authorize! @project, to: :update?

    if @project.update(project_params)
      redirect_to @project, notice: "Project updated successfully."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    authorize! @project, to: :destroy?
    @project.destroy
    redirect_to projects_path, notice: "Project deleted."
  end

  private

  def set_project
    @project = Project.find(params[:id])
  end

  def project_params
    params.require(:project).permit(:title, :status)
  end
end
