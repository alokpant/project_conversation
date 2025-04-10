# frozen_string_literal: true

# app/policies/application_policy.rb
class ApplicationPolicy < ActionPolicy::Base
  # By default allow access only to signed-in users
  authorize :user, optional: true

  def index?
    false
  end

  def show?
    false
  end

  def create?
    false
  end

  def new?
    create?
  end

  def update?
    false
  end

  def edit?
    update?
  end

  def destroy?
    false
  end
end
