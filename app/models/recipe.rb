class Recipe < ApplicationRecord

	has_many :recipe_ingredients, dependent: :destroy
	has_many :ingredients, through: :recipe_ingredients, dependent: :destroy

	scope :can_be_made_with_ingredients, ->(ingredient_ids) {
		joins(:recipe_ingredients)
			.where(recipe_ingredients: { ingredient_id: ingredient_ids })
			.where.not(recipe_ingredients: { ingredient_id: nil })
			.group('recipes.id')
			.having('COUNT(recipe_ingredients.ingredient_id) = (SELECT COUNT(*) FROM recipe_ingredients WHERE recipe_ingredients.recipe_id = recipes.id)')
	}

end
