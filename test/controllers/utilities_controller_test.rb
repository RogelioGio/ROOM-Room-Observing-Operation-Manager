require "test_helper"

class UtilitiesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @utility = utilities(:electric_meter)
    @room = rooms(:conference_room)
  end

  test "should get index" do
    get utilities_url
    assert_response :success
  end

  test "should get new" do
    get new_utility_url(room_id: @room.id)
    assert_response :success
  end

  test "should create utility" do
    assert_difference("Utility.count") do
      post utilities_url, params: { utility: { name: @utility.name, room_id: @utility.room_id, utility_type: @utility.utility_type } }
    end

    assert_redirected_to room_url(@room)
  end

  test "should show utility" do
    get utility_url(@utility, room_id: @room.id)
    assert_response :success
  end

  test "should get edit" do
    get edit_utility_url(@utility, room_id: @room.id)
    assert_response :success
  end

  test "should update utility" do
    patch utility_url(@utility), params: { utility: { name: @utility.name, room_id: @utility.room_id, utility_type: @utility.utility_type } }
    assert_redirected_to room_url(@room)
  end

  test "should destroy utility" do
    assert_difference("Utility.count", -1) do
      delete utility_url(@utility)
    end

    assert_redirected_to room_url(@room)
  end
end
