# frozen_string_literal: true

class Comment < ApplicationRecord
  # Associations
  belongs_to :user
  belongs_to :project

  # Validations
  validates :body, presence: true, length: { minimum: 2 }
end
