class AddIngredientDescriptionToRecipeIngredients < ActiveRecord::Migration[7.1]
  def change
    add_column :recipe_ingredients, :ingredient_description, :string
  end
end
