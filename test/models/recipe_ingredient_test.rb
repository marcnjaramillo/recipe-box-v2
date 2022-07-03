require "test_helper"

class RecipeIngredientTest < ActiveSupport::TestCase
  test "creates new ingredient if it doesn't exist" do
    ingredient_attributes=("salt")
    ing = Ingredient.find_or_create_by(name: ingredient_attributes)
    recipe_ing = RecipeIngredient.new(ingredient_id: ing.id, recipe_id: 1, quantity: "1")
    assert(recipe_ing.ingredient_id == ing.id)
  end

  test "doesn't create new ingredient if it already exists" do
    ing = Ingredient.find_or_create_by(name: "test")
    recipe_ing = RecipeIngredient.new(ingredient_id: ing.id, recipe_id: 1, quantity: "1")
    new_ing = Ingredient.find_or_create_by(name: "test")
    recipe_ing2 = RecipeIngredient.new(ingredient_id: new_ing.id, recipe_id: 2, quantity: "1")

    assert(recipe_ing2.ingredient_id == ing.id)
  end

end
