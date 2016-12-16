require 'test_helper'

class ChildrenControllerTest < ActionDispatch::IntegrationTest
  setup do
    @child = children(:one)
  end

  test "should get index" do
    get children_url
    assert_response :success
  end

  test "should get new" do
    get new_child_url
    assert_response :success
  end

  test "should create child" do
    assert_difference('Child.count') do
      post children_url, params: { child: { address: @child.address, c_phone_number: @child.c_phone_number, classroom_id: @child.classroom_id, full_name: @child.full_name, full_name_f: @child.full_name_f, l_phone_number: @child.l_phone_number, post_number: @child.post_number, sex_code: @child.sex_code, unique_num: @child.unique_num } }
    end

    assert_redirected_to child_url(Child.last)
  end

  test "should show child" do
    get child_url(@child)
    assert_response :success
  end

  test "should get edit" do
    get edit_child_url(@child)
    assert_response :success
  end

  test "should update child" do
    patch child_url(@child), params: { child: { address: @child.address, c_phone_number: @child.c_phone_number, classroom_id: @child.classroom_id, full_name: @child.full_name, full_name_f: @child.full_name_f, l_phone_number: @child.l_phone_number, post_number: @child.post_number, sex_code: @child.sex_code, unique_num: @child.unique_num } }
    assert_redirected_to child_url(@child)
  end

  test "should destroy child" do
    assert_difference('Child.count', -1) do
      delete child_url(@child)
    end

    assert_redirected_to children_url
  end
end
