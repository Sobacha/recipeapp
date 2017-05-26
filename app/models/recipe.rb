class Recipe < ApplicationRecord
  belongs_to :user
  validates :category, presence: true, length: { maximum: 50}
  validates :title, presence: true, length: { maximum: 50 }
  validates :ingredients, presence: true
  validates :direction, presence: true
  validates :user_id, presence: true
end
