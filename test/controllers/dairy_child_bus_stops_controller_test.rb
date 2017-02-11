require 'test_helper'

class DairyChildBusStopsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @dairy_child_bus_stop = dairy_child_bus_stops(:one)
  end

  test "should get index" do
    get dairy_child_bus_stops_url
    assert_response :success
  end

  test "should get new" do
    get new_dairy_child_bus_stop_url
    assert_response :success
  end

  test "should create dairy_child_bus_stop" do
    assert_difference('DairyChildBusStop.count') do
      post dairy_child_bus_stops_url, params: { dairy_child_bus_stop: { bus_stop_id: @dairy_child_bus_stop.bus_stop_id, child_id: @dairy_child_bus_stop.child_id, dairy_id: @dairy_child_bus_stop.dairy_id, dcb_code: @dairy_child_bus_stop.dcb_code, fare_code: @dairy_child_bus_stop.fare_code, pick_up_no: @dairy_child_bus_stop.pick_up_no, reason_text: @dairy_child_bus_stop.reason_text, unuse_flg: @dairy_child_bus_stop.unuse_flg } }
    end

    assert_redirected_to dairy_child_bus_stop_url(DairyChildBusStop.last)
  end

  test "should show dairy_child_bus_stop" do
    get dairy_child_bus_stop_url(@dairy_child_bus_stop)
    assert_response :success
  end

  test "should get edit" do
    get edit_dairy_child_bus_stop_url(@dairy_child_bus_stop)
    assert_response :success
  end

  test "should update dairy_child_bus_stop" do
    patch dairy_child_bus_stop_url(@dairy_child_bus_stop), params: { dairy_child_bus_stop: { bus_stop_id: @dairy_child_bus_stop.bus_stop_id, child_id: @dairy_child_bus_stop.child_id, dairy_id: @dairy_child_bus_stop.dairy_id, dcb_code: @dairy_child_bus_stop.dcb_code, fare_code: @dairy_child_bus_stop.fare_code, pick_up_no: @dairy_child_bus_stop.pick_up_no, reason_text: @dairy_child_bus_stop.reason_text, unuse_flg: @dairy_child_bus_stop.unuse_flg } }
    assert_redirected_to dairy_child_bus_stop_url(@dairy_child_bus_stop)
  end

  test "should destroy dairy_child_bus_stop" do
    assert_difference('DairyChildBusStop.count', -1) do
      delete dairy_child_bus_stop_url(@dairy_child_bus_stop)
    end

    assert_redirected_to dairy_child_bus_stops_url
  end
end
