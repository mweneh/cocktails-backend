class Cocktail < ApplicationRecord
    validates :name, presence: true, uniqueness: true
    validates :description, :image, :ingredients, :instructions, presence: true
end
  