class Cocktail < ApplicationRecord
    validates :name, presence: true, uniqueness: true
    validates :description, :image, presence: true
end
  