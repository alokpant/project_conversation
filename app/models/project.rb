# frozen_string_literal: true

class Project < ApplicationRecord
  STATUSES = %w[draft active completed archived].freeze

  # Associations
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :status_changes, dependent: :destroy

  # Validations
  validates :title, presence: true, length: { maximum: 100 }
  validates :status, presence: true, inclusion: { in: STATUSES }
end
