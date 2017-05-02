class Ingredient < ApplicationRecord
  belongs_to :recipe
  belongs_to :food
  validates :recipe_title, :food_name, presence: true
end
