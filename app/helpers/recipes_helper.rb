module RecipesHelper
  def recipe_image recipe
    image = recipe.image.present? ? recipe.image : "https://via.placeholder.com/500x500.png?text=No+image+to+display"
    image_tag(image, class: "img-fluid")
  end

  def recipe_thumbnail recipe
    image = recipe.image.present? ? recipe.image : "https://via.placeholder.com/500x500.png?text=No+image+to+display"
    image_tag(image, class: "recipe-thumbnail img-fluid img-thumbnail")
  end
end