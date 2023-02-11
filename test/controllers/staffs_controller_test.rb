require "test_helper"

class StaffsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get staffs_index_url
    assert_response :success
  end

  test "should get edit" do
    get staffs_edit_url
    assert_response :success
  end
end
