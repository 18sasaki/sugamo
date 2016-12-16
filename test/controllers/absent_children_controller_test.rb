require 'test_helper'

class AbsentChildrenControllerTest < ActionDispatch::IntegrationTest
  setup do
    @absent_child = absent_children(:one)
  end

  test "should get index" do
    get absent_children_url
    assert_response :success
  end

  test "should get new" do
    get new_absent_child_url
    assert_response :success
  end

  test "should create absent_child" do
    assert_difference('AbsentChild.count') do
      post absent_children_url, params: { absent_child: { absent_code: @absent_child.absent_code, child_id: @absent_child.child_id, class_room_id: @absent_child.class_room_id, dairy_id: @absent_child.dairy_id, reason_code: @absent_child.reason_code, reason_text: @absent_child.reason_text } }
    end

    assert_redirected_to absent_child_url(AbsentChild.last)
  end

  test "should show absent_child" do
    get absent_child_url(@absent_child)
    assert_response :success
  end

  test "should get edit" do
    get edit_absent_child_url(@absent_child)
    assert_response :success
  end

  test "should update absent_child" do
    patch absent_child_url(@absent_child), params: { absent_child: { absent_code: @absent_child.absent_code, child_id: @absent_child.child_id, class_room_id: @absent_child.class_room_id, dairy_id: @absent_child.dairy_id, reason_code: @absent_child.reason_code, reason_text: @absent_child.reason_text } }
    assert_redirected_to absent_child_url(@absent_child)
  end

  test "should destroy absent_child" do
    assert_difference('AbsentChild.count', -1) do
      delete absent_child_url(@absent_child)
    end

    assert_redirected_to absent_children_url
  end
end
