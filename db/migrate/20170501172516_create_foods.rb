class CreateFoods < ActiveRecord::Migration[5.0]
  def change
    create_table :foods do |t|
      t.string :category
      t.string :name
      t.date :purchase_date
      t.date :expiration_date
      t.integer :quantity
      #t.references :recipes, foreign_key: true

      t.timestamps
    end
  end
end
