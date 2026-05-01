class Room < ApplicationRecord
  has_many :utilities, dependent: :destroy
  has_many :schedules, dependent: :destroy
  belongs_to :building

  enum :status, { available: 0, occupied: 1, maintenance: 2 }

  after_update_commit :broadcast_occupancy_update

  def currently_occupied?
    now = Time.now
    current_time = now.strftime("%H:%M:%S")

    schedules.where("start_date <= ? AND end_date >= ?", now.to_date, now.to_date)
           .where("time(start_time) <= time(?) AND time(end_time) >= time(?)", now, now)
           .exists?
  end

  def broadcast_occupancy_update
    broadcast_replace_to("building_#{building_id}_rooms",
                        target: "room_#{id}".strip,
                        partial: "buildings/room_rows",
                        locals: { room: self })
  end
end
