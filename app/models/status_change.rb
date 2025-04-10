# frozen_string_literal: true

class StatusChange < ApplicationRecord
  # Associations
  belongs_to :user
  belongs_to :project

  # Validations
  validates :new_status, presence: true, inclusion: { in: Project::STATUSES }
  validates :previous_status, presence: true, inclusion: { in: Project::STATUSES }
  validate :status_must_be_different

  private

  def status_must_be_different
    errors.add(:new_status, "must be different from previous status") if previous_status == new_status
  end
end
