class Recipe < ApplicationRecord
  belongs_to :user
  has_many :recipe_ingredients, inverse_of: :recipe, dependent: :destroy
  has_many :ingredients, through: :recipe_ingredients
  has_many :comments, as: :commentable
  has_one_attached :image

  validates_presence_of :user, :name, :cook_time, :prep_time, :directions, :difficulty, :cuisine, :category

  accepts_nested_attributes_for :recipe_ingredients, reject_if: :all_blank, allow_destroy: true

  def self.categories
    ['Breakfast', 'Lunch', 'Dinner', 'Desserts', 'Soups', 'Salads', 'Sauces/Dips', 'Appetizers', 'Side Dishes', 'Drinks', 'Snacks']
  end
end
