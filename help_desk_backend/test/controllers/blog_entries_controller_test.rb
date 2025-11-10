require "test_helper"

class BlogEntriesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get blog_entries_index_url
    assert_response :success
  end

  test "should get show" do
    get blog_entries_show_url
    assert_response :success
  end

  test "should get new" do
    get blog_entries_new_url
    assert_response :success
  end

  test "should get create" do
    get blog_entries_create_url
    assert_response :success
  end

  test "should get edit" do
    get blog_entries_edit_url
    assert_response :success
  end

  test "should get update" do
    get blog_entries_update_url
    assert_response :success
  end

  test "should get destroy" do
    get blog_entries_destroy_url
    assert_response :success
  end
end
