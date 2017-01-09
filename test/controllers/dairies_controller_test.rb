require 'test_helper'

class DairiesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get dairies_index_url
    assert_response :success
  end

end
