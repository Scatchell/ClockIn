require 'test_helper'

class ClockTimesControllerTest < ActionController::TestCase
  setup do
    @clock_time = clock_times(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:clock_times)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create clock_time" do
    assert_difference('ClockTime.count') do
      post :create, clock_time: { day: @clock_time.day, in: @clock_time.in, out: @clock_time.out }
    end

    assert_redirected_to clock_time_path(assigns(:clock_time))
  end

  test "should show clock_time" do
    get :show, id: @clock_time
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @clock_time
    assert_response :success
  end

  test "should update clock_time" do
    put :update, id: @clock_time, clock_time: { day: @clock_time.day, in: @clock_time.in, out: @clock_time.out }
    assert_redirected_to clock_time_path(assigns(:clock_time))
  end

  test "should destroy clock_time" do
    assert_difference('ClockTime.count', -1) do
      delete :destroy, id: @clock_time
    end

    assert_redirected_to clock_times_path
  end
end
