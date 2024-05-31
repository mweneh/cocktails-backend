class CocktailsController < ApplicationController
    def index
      @cocktails = Cocktail.all
      render json: @cocktails
    end
  
    def show
      @cocktail = Cocktail.find(params[:id])
      render json: @cocktail
    end
  
    def create
      @cocktail = Cocktail.new(cocktail_params)
      if @cocktail.save
        render json: @cocktail, status: :created
      else
        render json: @cocktail.errors, status: :unprocessable_entity
      end
    end
  
    def update
      @cocktail = Cocktail.find(params[:id])
      if @cocktail.update(cocktail_params)
        render json: @cocktail
      else
        render json: @cocktail.errors, status: :unprocessable_entity
      end
    end
  
    def destroy
      @cocktail = Cocktail.find(params[:id])
      @cocktail.destroy
      head :no_content
    end
  
    private
  
    def cocktail_params
      params.require(:cocktail).permit(:name, :description, :ingredients, :instructions, :image)
    end
  end