class Todo < ApplicationRecord
  belongs_to :user

  validates :title, presence: true, length: { minimum: 1, maximum: 100 }
  validates :description, length: { maximum: 500 }

  scope :owned_by, ->(user) { where(user:) }
end
