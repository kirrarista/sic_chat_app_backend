require "test_helper"

class ExpertProfileTest < ActiveSupport::TestCase
  test "valid profile" do
    user = User.create!(username: "testuser", password: "password123")
    profile = ExpertProfile.new(user: user)
    assert profile.valid?
  end
end
