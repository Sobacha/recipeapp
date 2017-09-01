class Recipe < ApplicationRecord

  belongs_to :user

  validates :category, length: { maximum: 50 }
  validates :title, presence: true, length: { maximum: 50 }
  validates :user_id, presence: true

  # validates :url
  # standard validation
  validates :url, :url => {:allow_blank => true}

end
