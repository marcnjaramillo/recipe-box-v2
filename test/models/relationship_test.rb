require "test_helper"

class RelationshipTest < ActiveSupport::TestCase
  def setup
    @relationship = Relationship.new(follower_id: users(:user1).id, followed_id: users(:user2).id)
  end

  test "follower_id is required" do
    @relationship.follower_id = nil

    assert_not @relationship.valid?
  end

  test "followed_id is required" do
    @relationship.followed_id = nil

    assert_not @relationship.valid?
  end
  
  test "user can follow other users" do
    relationship = relationships(:relationship1)
    user = users(:user1)
    second_user = users(:user2)
    
    assert user.following?(second_user)
  end
  
  test "user can unfollow other users" do
    relationship = relationships(:relationship1)
    user = users(:user1)
    second_user = users(:user2)

    relationship.destroy

    assert_not user.following?(second_user)
  end

  test "user cannot follow their own account" do
    user = users(:user1)

    Relationship.new(follower_id: user.id, followed_id: user.id)
    assert_not user.following?(user)
  end
end
