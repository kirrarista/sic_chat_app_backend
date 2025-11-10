require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest

  # Register

  test "registers a new user with valid params" do
    post "/auth/register", params: { user: { username: "john_doe", password: "password123" } }

    assert_response :created

    json = JSON.parse(response.body)
    assert_equal "john_doe", json["user"]["username"]
    assert_equal "jwt_token_placeholder", json["token"]
  end

  test "fails to register user with invalid params" do
    post "/auth/register", params: { user: { username: "", password: "123" } }

    assert_response :unprocessable_entity

    json = JSON.parse(response.body)
    assert_includes json["errors"], "Username can't be blank"
    assert_includes json["errors"], "Password is too short (minimum is 6 characters)"
  end

  # Login

  test "logs in with valid credentials" do
    User.create!(username: "john", password: "password123")

    post "/auth/login", params: { username: "john", password: "password123" }

    assert_response :success
    json = JSON.parse(response.body)
    assert_equal "john", json["user"]["username"]
    assert_equal "jwt_token_placeholder", json["token"]
  end

  test "fails login with invalid credentials" do
    post "/auth/login", params: { username: "john", password: "wrongpass" }

    assert_response :unauthorized
    json = JSON.parse(response.body)
    assert_equal "Invalid username or password", json["error"]
  end

  # Logout

  test "logs out successfully" do
    # Simulate a logged-in session
    user = User.create!(username: "john", password: "password123")
    post "/auth/login", params: { username: user.username, password: "password123" }

    # Logout
    post "/auth/logout"
    assert_response :success

    json = JSON.parse(response.body)
    assert_equal "Logged out successfully", json["message"]
  end

  # Refresh

  test "refreshes token with valid session" do
    user = User.create!(username: "john", password: "password123")
    post "/auth/login", params: { username: user.username, password: "password123" }

    # Refresh
    post "/auth/refresh"
    assert_response :success

    json = JSON.parse(response.body)
    assert_equal "john", json["user"]["username"]
    assert_equal user.id, json["user"]["id"]
    assert_equal "jwt_token_placeholder", json["token"]
  end

  test "fails to refresh without session" do
    post "/auth/refresh"

    assert_response :unauthorized
    json = JSON.parse(response.body)
    assert_equal "No session found", json["error"]
  end

  # Me

  test "returns current user with valid session" do
    user = User.create!(username: "john", password: "password123")
    post "/auth/login", params: { username: user.username, password: "password123" }

    # Get current user
    get "/auth/me"
    assert_response :success

    json = JSON.parse(response.body)
    assert_equal "john", json["username"]
    assert_equal user.id, json["id"]
  end

  test "fails to get current user without session" do
    get "/auth/me"

    assert_response :unauthorized
    json = JSON.parse(response.body)
    assert_equal "No session found", json["error"]
  end
end
