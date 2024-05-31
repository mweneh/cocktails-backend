class CreateCocktails < ActiveRecord::Migration[7.0]
  def change
    create_table :cocktails do |t|
      t.string :name
      t.text :description
      t.text :ingredients
      t.text :instructions

      t.timestamps
    end
  end
end
