class AddUserIdToRecipe < ActiveRecord::Migration[5.0]
  def change
    add_column :recipes, :user_id, :int
  end
end
