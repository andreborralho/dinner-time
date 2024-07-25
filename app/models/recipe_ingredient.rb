class RecipeIngredient < ApplicationRecord

	belongs_to :ingredient, optional: true
	belongs_to :recipe

	scope :contains_ingredients, ->(ingredients) {
		where("ingredient_description ILIKE ANY (array[?])", ingredients.map { |ingredient| "% #{ingredient} %" })
=begin

		conditions = ingredients.map do |ingredient|
			"ingredient_description ~* '\\m#{ingredient}\\M'"
		end.join(' OR ')

		where(conditions)
=end
	}

	scope :contains_ingredient, ->(ingredient) {
		where("ingredient_description ~* '\\m#{ingredient}\\M'")
	}

	scope :contains_all_ingredients, ->(ingredients) {
		where(
			ingredient_description: ingredients.all? { |ingredient|
				where("ingredient_description ILIKE ?", "%#{ingredient}%").exists?
			}
		)
	}
end
