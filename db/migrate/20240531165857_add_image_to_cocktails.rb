class AddImageToCocktails < ActiveRecord::Migration[7.0]
  def change
    add_column :cocktails, :image, :text
  end
end
