class User < ApplicationRecord
  # Devise modules
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Associations
  has_many :projects, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :status_changes, dependent: :destroy

  # Validations
  validates :email, presence: true, uniqueness: { case_sensitive: false }

  # Callbacks
  before_validation :downcase_email

  private

  def downcase_email
    self.email = email.downcase.strip if email.present?
  end
end
