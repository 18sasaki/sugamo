require 'test_helper'

class BusCoursesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @bus_course = bus_courses(:one)
  end

  test "should get index" do
    get bus_courses_url
    assert_response :success
  end

  test "should get new" do
    get new_bus_course_url
    assert_response :success
  end

  test "should create bus_course" do
    assert_difference('BusCourse.count') do
      post bus_courses_url, params: { bus_course: { a_arrival_time: @bus_course.a_arrival_time, a_departure_time: @bus_course.a_departure_time, b_arrival_time: @bus_course.b_arrival_time, b_departure_time: @bus_course.b_departure_time, c_arrival_time: @bus_course.c_arrival_time, c_departure_time: @bus_course.c_departure_time, bus_id: @bus_course.bus_id, color: @bus_course.color, color_name: @bus_course.color_name, number: @bus_course.number } }
    end

    assert_redirected_to bus_course_url(BusCourse.last)
  end

  test "should show bus_course" do
    get bus_course_url(@bus_course)
    assert_response :success
  end

  test "should get edit" do
    get edit_bus_course_url(@bus_course)
    assert_response :success
  end

  test "should update bus_course" do
    patch bus_course_url(@bus_course), params: { bus_course: { a_arrival_time: @bus_course.a_arrival_time, a_departure_time: @bus_course.a_departure_time, b_arrival_time: @bus_course.b_arrival_time, b_departure_time: @bus_course.b_departure_time, c_arrival_time: @bus_course.c_arrival_time, c_departure_time: @bus_course.c_departure_time, bus_id: @bus_course.bus_id, color: @bus_course.color, color_name: @bus_course.color_name, number: @bus_course.number } }
    assert_redirected_to bus_course_url(@bus_course)
  end

  test "should destroy bus_course" do
    assert_difference('BusCourse.count', -1) do
      delete bus_course_url(@bus_course)
    end

    assert_redirected_to bus_courses_url
  end
end
