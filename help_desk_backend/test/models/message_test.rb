require "test_helper"

class MessageTest < ActiveSupport::TestCase
  test "valid message" do
    user = User.create!(username: "testuser", password: "password123")
    conversation = Conversation.create!(title: "Test", initiator: user)
    message = Message.new(conversation: conversation, sender: user, sender_role: "initiator", content: "Hello")
    assert message.valid?
  end

  test "invalid without content" do
    user = User.create!(username: "testuser", password: "password123")
    conversation = Conversation.create!(title: "Test", initiator: user)
    message = Message.new(conversation: conversation, sender: user, sender_role: "initiator")
    refute message.valid?
  end
end
