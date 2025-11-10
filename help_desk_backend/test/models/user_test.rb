require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "valid user" do
    user = User.new(username: "definitely_not_john_doe", password: "password123")
    assert user.valid?
  end

  test "duplicate user" do
    user = User.new(username: "john_doe", password: "password123")
    refute user.valid?
  end

  test "invalid without username" do
    user = User.new(password: "password123")
    refute user.valid?
  end

  test "invalid without password" do
    user = User.new(username: "john_doe")
    refute user.valid?
  end

  test "invalid with short password" do
    user = User.new(username: "shorty", password: "123")
    refute user.valid?
  end
end
