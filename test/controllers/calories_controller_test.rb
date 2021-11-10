require "test_helper"

class CaloriesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get calories_index_url
    assert_response :success
  end

  test "should get show" do
    get calories_show_url
    assert_response :success
  end

  test "should get new" do
    get calories_new_url
    assert_response :success
  end

  test "should get create" do
    get calories_create_url
    assert_response :success
  end

  test "should get edit" do
    get calories_edit_url
    assert_response :success
  end

  test "should get update" do
    get calories_update_url
    assert_response :success
  end

  test "should get destroy" do
    get calories_destroy_url
    assert_response :success
  end
end
