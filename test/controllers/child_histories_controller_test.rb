require 'test_helper'

class ChildHistoriesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get child_histories_index_url
    assert_response :success
  end

  test "should get show" do
    get child_histories_show_url
    assert_response :success
  end

end
