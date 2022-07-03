class RecipesController < ApplicationController
  before_action :set_recipe, only: [:show,:edit,:update,:destroy]
  
  def index
    @recipes = Recipe.all
  end

  def new
    if user_signed_in?
      @recipe = Recipe.new
    else
      redirect_to new_user_session_path
    end
  end

  def create
    @recipe = Recipe.new(recipe_params)
    if @recipe.save
      flash[:success] = "Recipe successfully created."

      respond_to do |f|
        f.html { redirect_to recipe_path(@recipe) }
        f.json { render json: @recipe }
      end
    else
      redirect_to new_recipe_path
    end
  end

  def show
    @user = @recipe.user.first_name
    respond_to do |f|
      f.html { render :show }
      f.json { render json:  @recipe }
    end
  end

  def edit
    if !user_signed_in?
      redirect_to new_user_session_path
    elsif current_user.id != @recipe.user_id
      redirect_to root_path
      flash[:danger] = "You are not authorized for this action."
    end
  end

  def update
    if @recipe.update(recipe_params)
      redirect_to recipe_path(@recipe)
      flash[:success] = "Recipe successfully updated."
    else
      redirect_to edit_recipe_path(@recipe)
    end
  end

  def destroy
    @recipe.destroy
    flash[:success] = "Recipe successfully deleted."
    redirect_to recipes_path
  end

  private

  def set_recipe
    @recipe = Recipe.find(params[:id])
  end

  def recipe_params
    params.require(:recipe).permit(
      :name,
      :category,
      :prep_time,
      :cook_time,
      :user_id,
      :image,
      :directions,
      :difficulty,
      :cuisine,
      recipe_ingredients_attributes: [
      :id,
      :recipe_id,
      :ingredient_id,
      :quantity,
      :_destroy,
      ingredient_attributes: [:id, :name, :_destroy]]
    )
  end
end
