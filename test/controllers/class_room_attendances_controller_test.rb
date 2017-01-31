require 'test_helper'

class ClassRoomAttendancesControllerTest < ActionDispatch::IntegrationTest
  test "should get confirm" do
    get class_room_attendances_confirm_url
    assert_response :success
  end

end
