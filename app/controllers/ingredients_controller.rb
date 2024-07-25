class IngredientsController < ApplicationController

	def index
		@ingredients = Ingredient.all
	end

	def new
		@ingredient = Ingredient.new
	end

	def create
		@ingredient = Ingredient.new(ingredient_params)
		@ingredient.save
		find_recipes

		redirect_to ingredients_path
	end

	def edit
		@ingredient = Ingredient.find(params[:id])
	end

	def update
		@ingredient = Ingredient.find(params[:id])
		@ingredient.update(ingredient_params)
		find_recipes
		redirect_to ingredients_path
	end

	def destroy
		@ingredient = Ingredient.find(params[:id])
		@ingredient.destroy
	end

	private

	def ingredient_params
		params.require(:ingredient).permit(:name, :quantity, :unit)
	end

	def find_recipes
		recipe_ingredients = RecipeIngredient.contains_ingredient(@ingredient.name)
		recipe_ingredients.update_all(ingredient_id: @ingredient.id)
	end
end
