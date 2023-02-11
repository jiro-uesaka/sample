require "test_helper"

class WorkPatternsControllerTest < ActionDispatch::IntegrationTest
  test "should get edit" do
    get work_patterns_edit_url
    assert_response :success
  end

  test "should get index" do
    get work_patterns_index_url
    assert_response :success
  end
end
