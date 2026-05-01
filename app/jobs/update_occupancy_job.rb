class UpdateOccupancyJob < ApplicationJob
  queue_as :default

  def perform(room_id)
    room = Room.find(room_id)
    room.broadcast_occupancy_update
  end
end
