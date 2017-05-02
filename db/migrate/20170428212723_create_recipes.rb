class CreateRecipes < ActiveRecord::Migration[5.0]
  def change
    create_table :recipes do |t|

      t.string :category
      t.string :title
      t.text :ingredients
      t.text :direction
      t.text :url
      #t.references :foods, foreign_key: true

      t.timestamps
    end
  end
end
