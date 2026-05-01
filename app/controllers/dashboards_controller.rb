class DashboardsController < ApplicationController
  def index
    @total_room_across_buildings = Building.joins(:rooms).count
    @total_available_rooms = Room.where(status: 0).count
    @total_occupied_rooms = Room.where(status: 1).count
    @total_maintenance_rooms = Room.where(status: 2).count

    @rooms = Room.includes(:building).order(created_at: :desc).limit(5)
  end
end
