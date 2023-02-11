require "test_helper"

class ShiftsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get shifts_new_url
    assert_response :success
  end

  test "should get index" do
    get shifts_index_url
    assert_response :success
  end

  test "should get show" do
    get shifts_show_url
    assert_response :success
  end

  test "should get edit" do
    get shifts_edit_url
    assert_response :success
  end

  test "should get preview" do
    get shifts_preview_url
    assert_response :success
  end
end
