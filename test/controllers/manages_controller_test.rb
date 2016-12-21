require 'test_helper'

class ManagesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get manages_index_url
    assert_response :success
  end

end
