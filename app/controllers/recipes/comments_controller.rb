class Recipes::CommentsController < ApplicationController
  include Commentable

  before_action :set_commentable

  private

    def set_commentable
      @commentable = Recipe.find(params[:recipe_id])
    end
end
