namespace :recipes do
	desc "Import recipes from a JSON file"
	task import: :environment do
		file_path = Rails.root.join('public', 'recipes-en.json')
		data = JSON.parse(File.read(file_path))

		Recipe.destroy_all
		data.each do |recipe_data|
			recipe = Recipe.new(
				title: recipe_data['title'],
				cooking_time: recipe_data['cook_time'],
				preparation_time: recipe_data['prep_time'],
				image: parsed_image_url(recipe_data['image'])
			)
			recipe.save!

			recipe_data['ingredients'].each do |raw_ingredient|
				recipe.recipe_ingredients.create!(ingredient_description: raw_ingredient)

=begin
				if raw_ingredient.include?("cup")
					#puts ingredient
					parsed_ingredient = extract_data(raw_ingredient)
					quantity = parsed_ingredient[1]&.strip || nil
					units = parsed_ingredient[2]&.strip || nil
					ingredient = parsed_ingredient[3]&.strip

					x = { quantity: quantity, units: units, ingredient: ingredient }
					if quantity.blank? || units.blank? || ingredient.blank?
						puts raw_ingredient
						pp x
					end
				end
=end
			end
		end
	end

	private

	def parsed_image_url(url)
		url_to_remove = "https://imagesvc.meredithcorp.io/v3/mm/image?url="
		url.gsub(Regexp.new(Regexp.escape(url_to_remove)), "")
	end

	def extract_ingredient(ingredient)
		# Match the ingredient part, which is everything after the first quantity unit
		ingredient.match(/(?:\d+\s?(?:tablespoon|tablespoons|teaspoon|teaspoons|pound|clove|ounce|slices?|cup|cups|gallon|gallons|pinch|pounds|½|¼|1\/2|1\/4)\s.+?\s)?(.+)/)[1]
	end

	def extract_data(ingredient)
		# Match the ingredient part, which is everything after the first quantity unit
		#ingredient.match(/(\d+\s*[\d\/¼½¾⅛⅓⅔]*)?\s*(tablespoons?|teaspoons?|pounds?|cloves?|ounces?|slices?|cups?|pinch|bags?|packages?|cans?|leaves?)?\s*([^,-]+)/i)
		ingredient.match(/([\d\s\/\u00BC-\u00BE\u2150-\u215E]*)\b*(tablespoons?|teaspoons?|pounds?|cloves?|ounces?|slices?|cups?|pinch|bags?|packages?|cans?|leaves?)\b*([^,–]*)/)
	end
end