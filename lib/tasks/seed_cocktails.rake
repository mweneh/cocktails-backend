
namespace :db do
    desc "Seed cocktails from TheCocktailDB"
    task seed_cocktails: :environment do
      require 'http'
  
      url = 'https://www.thecocktaildb.com/api/json/v1/1/filter.php?a=Alcoholic'
      response = HTTP.get(url)
  
      if response.status.success?
        cocktails = response.parse['drinks']
        
        cocktails.each do |cocktail|
          Cocktail.find_or_create_by(
            name: cocktail['strDrink'],
            image:cocktail['strDrinkThumb'],
            description: "Alcoholic Cocktail", 
            ingredients: "See instructions", 
            instructions: "No instructions provided" 
          )
        end
        puts "Successfully seeded cocktails!"
      else
        puts "Failed to fetch data from the API"
      end
    end
  end
  