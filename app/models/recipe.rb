class Recipe < ApplicationRecord

	has_many :recipe_ingredients, dependent: :destroy
	has_many :ingredients, through: :recipe_ingredients, dependent: :destroy

=begin
	scope :can_be_made_with_ingredients, ->(ingredients) {
		where(
			id: RecipeIngredient.select(:recipe_id).where("ingredient_description ILIKE ?", "%#{ingredient}%").group(:recipe_id).having("COUNT(*) = ?", ingredients.size).pluck(:recipe_id)
		)
	}
=end

	scope :can_be_made_with_ingredients_x, ->(ingredients) {
		joins(:recipe_ingredients)
			.where(recipe_ingredients: { ingredient_id: ingredients.ids })
			.group('recipes.id')
			.having('COUNT(recipe_ingredients.ingredient_id) = ?', ingredients.count)
	}

	scope :can_be_made_with_ingredients, ->(ingredient_ids) {
		joins(:recipe_ingredients)
			.where(recipe_ingredients: { ingredient_id: ingredient_ids })
			.where.not(recipe_ingredients: { ingredient_id: nil })
			.group('recipes.id')
			.having('COUNT(recipe_ingredients.ingredient_id) = (SELECT COUNT(*) FROM recipe_ingredients WHERE recipe_ingredients.recipe_id = recipes.id)')
	}

end
