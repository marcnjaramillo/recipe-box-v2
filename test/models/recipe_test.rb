require "test_helper"

class RecipeTest < ActiveSupport::TestCase
  def setup
    @recipe = recipes(:recipe1)
  end

  test "recipe must belong to a user" do
    @recipe.user_id = nil

    assert_not @recipe.valid?
  end

  test "recipe will not save if errors are present" do
    @recipe.cook_time = " "

    assert_not @recipe.valid?
  end
end
