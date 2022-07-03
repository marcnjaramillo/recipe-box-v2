class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :profile_image
  has_many :recipes, dependent: :destroy
  has_many :comments

  has_many :active_relationships, 
            class_name: "Relationship", 
            foreign_key: "follower_id", 
            dependent: :destroy

  has_many :following, through: :active_relationships,  source: :followed

  has_many :passive_relationships, 
            class_name: "Relationship", 
            foreign_key: "followed_id", 
            dependent: :destroy

  has_many :followers, through: :passive_relationships

  validates_presence_of :first_name, :last_name, :username
  validates_uniqueness_of :username, :email

  def following?(other_user)
    self&.following&.include?(other_user)
  end

  def fullname
    "#{first_name} #{last_name}"
  end

  def to_param
    username
  end
end
