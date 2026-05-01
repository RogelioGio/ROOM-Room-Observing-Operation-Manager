require "test_helper"

class SchedulesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @schedule = schedules(:meeting_schedule)
    @room = rooms(:conference_room)
  end

  test "should get index" do
    get schedules_url
    assert_response :success
  end

 test "should get new" do
    # Pass the room_id so the controller can find @room
    get new_schedule_url(room_id: @room.id)
    assert_response :success
  end

  test "should create schedule" do
    assert_difference("Schedule.count") do
      post schedules_url, params: { schedule: { end_time: @schedule.end_time, room_id: @schedule.room_id, start_time: @schedule.start_time } }
    end

    assert_redirected_to room_url(@room)
  end

  test "should show schedule" do
    get schedule_url(@schedule)
    assert_response :success
  end

  test "should get edit" do
    get edit_schedule_url(@schedule)
    assert_response :success
  end

  test "should update schedule" do
    patch schedule_url(@schedule), params: { schedule: { end_time: @schedule.end_time, room_id: @schedule.room_id, start_time: @schedule.start_time } }
    assert_redirected_to room_url(@room)
  end

  test "should destroy schedule" do
    assert_difference("Schedule.count", -1) do
      delete schedule_url(@schedule)
    end

    assert_redirected_to room_url(@room)
  end
end
