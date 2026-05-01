class BuildingChannel < ApplicationCable::Channel
  def subscribed
    # stream_from "some_channel"
    stream_from "building_#{params[:building_id]}_channel"

    RoomOccupancyStatusJob.perform_later(params[:building_id])
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
