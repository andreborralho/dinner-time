class RecipesController < ApplicationController
  before_action :set_recipe, only: %i[ show ]

  def index
    @recipes = Recipe.paginate(page: params[:page], per_page: 30)
  end

  def show
  end

  def recommended
    @ingredients = Ingredient.has_quantity
    @recipes = Recipe.can_be_made_with_ingredients(@ingredients).paginate(page: params[:page], per_page: 30)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_recipe
      @recipe = Recipe.find(params[:id])
    end
end
