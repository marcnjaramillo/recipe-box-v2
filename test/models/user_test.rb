require "test_helper"

class UserTest < ActiveSupport::TestCase

  def setup
    @user = users(:user1)
  end

  test "successfully creates new user" do
    assert @user.valid?
  end

  test "joins first name and last name" do
    assert_equal(@user.fullname, "First User")
  end

  test "will not save user with duplicate username" do
    @user.save

    new_user = @user.dup
    new_user.email = "testuser@gmail.com"

    assert_not new_user.valid?
  end

  test "will not save user with duplicate email" do
    @user.save

    new_user = @user.dup
    new_user.username = "testuser"

    assert_not new_user.valid?
  end

  test "will not save user without a first name" do
    @user.save

    new_user = @user.dup
    new_user.first_name = " "
    new_user.username = "testuser"
    new_user.email = "testuser@gmail.com"

    assert_not new_user.valid?
  end

  test "will not save user without a last name" do
    @user.save

    new_user = @user.dup
    new_user.last_name = " "
    new_user.username = "testuser"
    new_user.email = "testuser@gmail.com"

    assert_not new_user.valid?
  end

  test "will not save user without a username" do
    @user.save

    new_user = @user.dup
    new_user.username = " "
    new_user.email = "testuser@gmail.com"

    assert_not new_user.valid?
  end

  test "will not save user without an email address" do
    @user.save

    new_user = @user.dup
    new_user.username = "testuser"
    new_user.email = " "

    assert_not new_user.valid?
  end

  test "will not save user without a password" do
    @user.save
    
    new_user = @user.dup
    new_user.username = "testuser"
    new_user.email = "testuser@gmail.com"
    new_user.encrypted_password = " "

    assert_not new_user.valid?
  end

  test "will not save if admin field is empty" do
    @user.save

    new_user = @user.dup
    new_user.username = "testuser"
    new_user.email = "testuser@gmail.com"
    new_user.admin = nil

    assert_not new_user.valid?
  end
end
