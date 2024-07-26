class RecipeIngredient < ApplicationRecord

	belongs_to :ingredient, optional: true
	belongs_to :recipe

	scope :contains_ingredient, ->(ingredient) {
		where("ingredient_description ~* '\\m#{ingredient}\\M'")
	}

end
