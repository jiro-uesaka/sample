require "test_helper"

class HeadcountsControllerTest < ActionDispatch::IntegrationTest
  test "should get edit" do
    get headcounts_edit_url
    assert_response :success
  end
end
