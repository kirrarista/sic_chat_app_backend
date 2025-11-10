require "test_helper"

class HealthControllerTest < ActionDispatch::IntegrationTest
  test "should get health" do
    get "/health"
    assert_response :ok

    json = JSON.parse(@response.body)
    assert_equal "ok", json["status"]
  end
end
