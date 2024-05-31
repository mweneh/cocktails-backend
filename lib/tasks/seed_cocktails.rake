# lib/tasks/seed_cocktails.rake
namespace :db do
    desc "Seed cocktails from TheCocktailDB"
    task seed_cocktails: :environment do
      require 'http'
  
      base_url = 'https://www.thecocktaildb.com/api/json/v1/1'
      filter_url = "#{base_url}/filter.php?a=Alcoholic"
      filter_response = HTTP.get(filter_url)
  
      if filter_response.status.success?
        cocktails = filter_response.parse['drinks']
  
        cocktails.each do |cocktail|
          detail_url = "#{base_url}/lookup.php?i=#{cocktail['idDrink']}"
          detail_response = HTTP.get(detail_url)
          if detail_response.status.success?
            cocktail_details = detail_response.parse['drinks'].first
            ingredients = (1..15).map do |i|
              ingredient = cocktail_details["strIngredient#{i}"]
              measure = cocktail_details["strMeasure#{i}"]
              "#{measure} #{ingredient}".strip if ingredient
            end.compact.join(', ')
  
            Cocktail.find_or_create_by(
              name: cocktail_details['strDrink'],
              description: cocktail_details['strCategory'], 
              ingredients: ingredients,
              instructions: cocktail_details['strInstructions'],
              image: cocktail_details['strDrinkThumb']
            )
          end
        end
        puts "Successfully seeded cocktails!"
      else
        puts "Failed to fetch data from the API"
      end
    end
  end
  