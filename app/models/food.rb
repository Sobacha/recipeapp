class Food < ApplicationRecord

  belongs_to :user

  validates :category, length: { maximum: 50 }
  validates :name, presence: true, length: { maximum: 50 }
  validates :user_id, presence: true

end
