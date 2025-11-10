require "test_helper"

class MessagesControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = User.create!(username: "testuser", password: "password123")
    @other_user = User.create!(username: "otheruser", password: "password123")
    @conversation = Conversation.create!(title: "Test Conversation", initiator: @user, status: "waiting")
  end

  # GET /conversations/:conversation_id/messages

  test "returns messages for a conversation" do
    message = Message.create!(
      conversation: @conversation,
      sender: @user,
      sender_role: "initiator",
      content: "Hello, I need help"
    )

    post "/auth/login", params: { username: @user.username, password: "password123" }
    get "/conversations/#{@conversation.id}/messages"

    assert_response :ok
    json = JSON.parse(response.body)
    assert_equal 1, json.length
    assert_equal message.id.to_s, json.first["id"]
    assert_equal "Hello, I need help", json.first["content"]
  end

  test "GET /messages requires authentication" do
    get "/conversations/#{@conversation.id}/messages"
    assert_response :unauthorized
  end

  test "GET /messages returns 404 when conversation doesn't exist" do
    post "/auth/login", params: { username: @user.username, password: "password123" }
    get "/conversations/99999/messages"
    assert_response :not_found
  end

  # POST /messages

  test "creates a message in a conversation" do
    post "/auth/login", params: { username: @user.username, password: "password123" }

    assert_difference "Message.count", 1 do
      post "/messages", params: { conversationId: @conversation.id, content: "Hello, I need help" }
    end

    assert_response :created
    json = JSON.parse(response.body)
    assert_equal "Hello, I need help", json["content"]
    assert_equal "initiator", json["senderRole"]
  end

  test "creates message with expert role when sender is assigned expert" do
    @conversation.update!(assigned_expert: @other_user, status: "active")
    post "/auth/login", params: { username: @other_user.username, password: "password123" }

    post "/messages", params: { conversationId: @conversation.id, content: "I can help" }

    assert_response :created
    json = JSON.parse(response.body)
    assert_equal "expert", json["senderRole"]
  end

  test "POST /messages requires authentication" do
    post "/messages", params: { conversationId: @conversation.id, content: "Test" }
    assert_response :unauthorized
  end

  test "POST /messages requires content" do
    post "/auth/login", params: { username: @user.username, password: "password123" }
    post "/messages", params: { conversationId: @conversation.id, content: "" }
    assert_response :unprocessable_entity
    json = JSON.parse(response.body)
    assert_includes json["errors"], "Content can't be blank"
  end

  # PUT /messages/:id/read

  test "marks message as read" do
    @conversation.update!(assigned_expert: @other_user, status: "active")
    message = Message.create!(
      conversation: @conversation,
      sender: @other_user,
      sender_role: "expert",
      content: "I can help you"
    )

    post "/auth/login", params: { username: @user.username, password: "password123" }
    put "/messages/#{message.id}/read"

    assert_response :ok
    json = JSON.parse(response.body)
    assert_equal true, json["success"]

    message.reload
    assert_equal true, message.is_read
  end

  test "cannot mark own message as read" do
    message = Message.create!(
      conversation: @conversation,
      sender: @user,
      sender_role: "initiator",
      content: "My own message"
    )

    post "/auth/login", params: { username: @user.username, password: "password123" }
    put "/messages/#{message.id}/read"

    assert_response :forbidden
    json = JSON.parse(response.body)
    assert_equal "Cannot mark your own messages as read", json["error"]
  end

  test "PUT /messages/:id/read requires authentication" do
    message = Message.create!(
      conversation: @conversation,
      sender: @user,
      sender_role: "initiator",
      content: "Test"
    )

    put "/messages/#{message.id}/read"
    assert_response :unauthorized
  end
end
