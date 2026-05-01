class Schedule < ApplicationRecord
  belongs_to :room

  validates :start_time, :end_time, presence: true
  validate :end_time_after_start_time
  # validate :no_overlapping_schedules

  def frequency=(value)
    if value.is_a?(Array)
      # Join array elements with a comma and remove empty strings
      super(value.reject(&:blank?).join(", "))
    else
      super(value)
    end
  end

  def frequency_list
    frequency.to_s.split(", ")
  end

  after_create_commit :roomOccupancy_status_job
  after_update_commit :roomOccupancy_status_job

  private

  def roomOccupancy_status_job
    RoomOccupancyStatusJob.perform_later(room.building_id)
  end

  def end_time_after_start_time
    return if end_time.blank? || start_time.blank?

    if end_time <= start_time
      errors.add(:end_time, "must be after the start time")
    end
  end

  def no_overlapping_schedules
    return if start_time.blank? || end_time.blank?

    overlapping_schedules = Schedule.where(room_id: room_id)
                            .where.not(id: id)
                            .where("start_time < ? AND end_time > ?", end_time, start_time)

    if overlapping_schedules.exists?
      errors.add(:base, "Schedule overlaps with an existing schedule for this room")
    end
  end
end
