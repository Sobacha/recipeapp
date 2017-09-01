class DropIngredients < ActiveRecord::Migration[5.0]
  \
  def change
    drop_table :ingredients
  end

end
