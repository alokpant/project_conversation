# frozen_string_literal: true

class ProjectPolicy < ApplicationPolicy
  def show?
    true # anyone can view a project
  end

  def create?
    user.present? # only logged-in users can create projects
  end

  def update?
    user_is_owner?
  end

  def change_status?
    user_is_owner?
  end

  def comment?
    true # anyone logged in can comment
  end

  private

  def user_is_owner?
    record.user == user
  end
end
