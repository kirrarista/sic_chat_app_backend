require "test_helper"

class ExpertAssignmentTest < ActiveSupport::TestCase
  test "valid assignment" do
    user = User.create!(username: "testuser", password: "password123")
    expert = User.create!(username: "expert", password: "password123")
    conversation = Conversation.create!(title: "Test", initiator: user)
    assignment = ExpertAssignment.new(conversation: conversation, expert: expert, status: "active")
    assert assignment.valid?
  end
end
