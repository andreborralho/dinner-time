class CreateRecipes < ActiveRecord::Migration[7.1]
  def change
    create_table :recipes do |t|
      t.string :title
      t.integer :cooking_time
      t.integer :preparation_time
      t.string :image

      t.timestamps
    end
  end
end
