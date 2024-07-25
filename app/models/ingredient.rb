class Ingredient < ApplicationRecord

	validates_uniqueness_of :name, message: "already exists"

	has_many :recipe_ingredients
	has_many :recipes, through: :recipe_ingredients

	UNITS = %w[
		gram
		kilogram
		liter
		milliliter
		teaspoon
		tablespoon
		cup
		pound
		fluid_ounce
	].freeze

	scope :has_quantity, -> { where.not(quantity: [nil, 0]) }

end
