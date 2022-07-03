require "test_helper"
class RecipesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:user1)
    sign_in @user
    @recipe = recipes(:recipe1)
  end

  test "any user can view recipes index page" do
    sign_out @user

    get recipes_url

    assert_response :success
  end

  test "any user can view recipes" do
    sign_out @user

    get recipe_url(@recipe)

    assert_response :success
  end

  test "logged in users can access new recipe form" do
    get new_recipe_url
    assert_response :success
  end

  test "logged in users can create new recipes" do
   
    assert_difference("Recipe.count", 1) do
      post recipes_url, params: { recipe: 
          {
            name: "recipe test", 
            cook_time: "1 min", 
            prep_time: "1 min",
            directions: "do something",
            category: "Breakfast",
            difficulty: "Beginner",
            cuisine: "American",
            recipe_ingredients_attributes: [ quantity: "1 oz",
            ingredient_attributes: ingredient_attributes=(Ingredient.new(name: "some test"))
            ],
            user_id: users(:user1).id
          },
        }
    end
  
    assert_redirected_to recipe_path(Recipe.last)
    assert_equal "Recipe successfully created.", flash[:success]
  end

  test "failed validations redirect to new recipe form" do
   
    post recipes_url, params: { recipe: 
        {
          name: "recipe test", 
          cook_time: " ", 
          prep_time: "1 min", 
          category: "Breakfast", 
          directions: "do something",
          category: "Breakfast",
          difficulty: "Beginner",
          cuisine: "American",
          recipe_ingredients_attributes: [ quantity: "1 oz",
          ingredient_attributes: ingredient_attributes=(Ingredient.new(name: "some test"))
          ],
          user_id: users(:user1).id
        },
      }
  
    assert_redirected_to new_recipe_url
  end

  test "logged in users can update their own recipe" do
  
    patch recipe_url(@recipe), params: { recipe: 
      {
        name: "updated recipe test", 
        cook_time: "1 min", 
        prep_time: "1 min",
        directions: "do something",
        category: "Breakfast",
        difficulty: "Beginner",
        cuisine: "American",
        recipe_ingredients_attributes: [ quantity: "1 oz",
        ingredient_attributes: ingredient_attributes=(Ingredient.new(name: "some test"))
        ],
        user_id: users(:user1).id
      },
    }
  
    assert_redirected_to recipe_path(@recipe)

    @recipe.reload
    assert_equal "updated recipe test", @recipe.name
  end

  test "recipe changes are not saved if there are errors" do
  
    patch recipe_url(@recipe), params: { recipe: 
      {
        name: "", 
        cook_time: "1 min", 
        prep_time: "1 min",
        directions: "do something",
        category: "Breakfast",
        difficulty: "Beginner",
        cuisine: "American",
        recipe_ingredients_attributes: [ quantity: "1 oz",
        ingredient_attributes: ingredient_attributes=(Ingredient.new(name: "some test"))
        ],
        user_id: users(:user1).id
      },
    }
  
    assert_redirected_to edit_recipe_path(@recipe)
  end

  test "users must login before editing their recipe" do
    sign_out @user

    get edit_recipe_url(@recipe)
    
    assert_redirected_to new_user_session_path
  end

  test "users cannot edit another user's recipes" do

    get edit_recipe_url(recipes(:recipe2))
    
    assert_redirected_to root_path
    assert_equal "You are not authorized for this action.", flash[:danger]
  end

  test "logged in users can delete their own recipes" do
    assert_difference("Recipe.count", -1) do
      delete recipe_url(@recipe)
    end
  
    assert_redirected_to recipes_path
  end

  test "users must sign in before creating recipes" do
    sign_out @user

    get new_recipe_url

    assert_redirected_to new_user_session_path
  end
        
end
