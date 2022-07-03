class ProfileController < ApplicationController
  include ProfileHelper
  before_action :set_user

  def recipes
    render 'user_recipes'
  end

  def following
    render 'following'
  end

  def followers
    render 'followers'
  end

  def show 

  end

  def follow
    Relationship.find_or_create_by(follower_id: current_user.id, followed_id: @user.id) unless current_user.id == @user.id
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: [
          turbo_stream.replace(dom_id_for_follower(@user),
                               partial: 'profile/follow_button',
                               locals: { user: @user }),
          turbo_stream.update("#{@user.id}-follower-count",
                              partial: 'profile/follower_count',
                              locals: { user: @user })
        ]
      end
    end
  end

  def unfollow
    current_user.following.where(follower_id: current_user.id, followed_id: @user.id).destroy_all
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: [
          turbo_stream.replace(dom_id_for_follower(@user),
                               partial: 'profile/follow_button',
                               locals: { user: @user }),
          turbo_stream.update("#{@user.id}-follower-count",
                              partial: 'profile/follower_count',
                              locals: { user: @user })
        ]
      end
    end
  end

  private

  def set_user
    @user = User.find_by(username: params[:username])
  end
end