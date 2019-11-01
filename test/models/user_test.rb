require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "should save user with all fields" do
    user = User.new
    user.username = "testuser",
    user.email = "test@email.com",
    user.password = "testpass"

    assert user.save
  end

  test "should not save user without email, username, password" do
    user = User.new
    assert_not user.save
  end

  test "should not save user without email" do
    user = User.new
    user.username = "testuser",
    user.password = "testpass"

    assert_not user.save
  end

  test "should not save user with invalid email" do
    user = User.new
    user.username = "testuser",
    user.email = "test@"
    user.password = "testpass"

    assert_not user.save
  end

  test "should not save user with duplicate email" do
    user = User.new
    user.username = "testuser",
    user.email = "test@email.com",
    user.password = "testpass"

    user.save

    user1 = User.new
    user1.username = "testuser1",
    user1.email = "test@email.com",
    user1.password = "testpass"

    assert_not user1.save
  end

  test "should not save user without username" do
    user = User.new
    user.email = "test@email.com"
    user.password = "testpass"

    assert_not user.save
  end

  test "should not save user with duplicate username" do
    user = User.new
    user.username = "testuser"
    user.email = "test@email.com"
    user.password = "testpass"

    user1 = User.new
    user1.username = "testuser"
    user1.email = "test1@email.com"
    user1.password = "testpass"

    assert_not user.save && user1.save
  end

  test "should not save user without password" do
    user = User.new
    user.username = "testuser"
    user.email = "test@email.com"

    assert_not user.save
  end

  test "should not save user with password lesser thant 6 chars" do
    user = User.new
    user.username = "testuser"
    user.email = "test@email.com"
    user.password = "test"

    assert_not user.save
  end
end
