class CreateRecipeIngredients < ActiveRecord::Migration[7.0]
  def change
    create_table :recipe_ingredients do |t|
      t.string      :quantity, null: false
      t.references  :recipe
      t.references  :ingredient
      t.timestamps
    end
  end
end
