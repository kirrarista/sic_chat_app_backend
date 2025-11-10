require "test_helper"

class ConversationTest < ActiveSupport::TestCase
  test "valid conversation" do
    user = User.create!(username: "testuser", password: "password123")
    conversation = Conversation.new(title: "Help request", initiator: user)
    assert conversation.valid?
  end

  test "invalid without title" do
    user = User.create!(username: "testuser", password: "password123")
    conversation = Conversation.new(initiator: user)
    refute conversation.valid?
  end
end
