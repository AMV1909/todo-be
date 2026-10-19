class User < ApplicationRecord
  before_validation { self.email = email&.strip&.downcase }

  validates :first_name, presence: true, length: { minimum: 1, maximum: 50 }
  validates :last_name, presence: true, length: { minimum: 1, maximum: 50 }
  validates :email, presence: true, uniqueness: { case_sensitive: false }, length: { maximum: 100 }, format: { with: URI::MailTo::EMAIL_REGEXP, message: "must be a valid email address" }
  validates :password, length: { minimum: 8, maximum: 50 }, allow_nil: true

  has_many :todos, dependent: :destroy

  has_secure_password
end
