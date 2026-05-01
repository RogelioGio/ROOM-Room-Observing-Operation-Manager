class RoomOccupancyStatusJob < ApplicationJob
  queue_as :default

  def perform(building_id)
    building = Building.find(building_id)
    return unless building

    rooms_data = building.rooms.map do |room|
      {
        room_id: room.id,
        occupied: room.currently_occupied?
      }
    end

    puts "\n[SMART TRIGGER] Checking building: #{building.name} (ID: #{building_id})"
    puts "[SMART TRIGGER] Current Time: #{Time.current.strftime('%H:%M:%S')}"

    ActionCable.server.broadcast("building_#{building_id}_channel", { rooms: rooms_data, timestamp: Time.current.strftime("%H:%M:%S") })

    next_event_time = find_next_event_time(building)

    if next_event_time
      seconds_to_wait = (next_event_time - Time.current).to_i

      puts "[SMART TRIGGER] SUCCESS: Next status change found at #{next_event_time.strftime('%H:%M:%S')}"
      puts "[SMART TRIGGER] ACTION: Sleeping for #{seconds_to_wait} seconds...\n\n"
      RoomOccupancyStatusJob.set(wait_until: next_event_time).perform_later(building_id)
    else
      puts "[SMART TRIGGER] INFO: No upcoming status changes found. Will check again in 5 minutes.\n\n"
    end
  end

  private

  def find_next_event_time(building)
    now = Time.now
    today = now.to_date

   all_schedules = Schedule.where(room_id: building.rooms.pluck(:id))

    puts "--- DB AUDIT: #{building.name} ---"
    puts "Current Time: #{Time.now.strftime('%I:%M:%S %p')}" # e.g. 06:45:00 PM

    if all_schedules.none?
      puts "RESULT: No schedules found."
    else
      all_schedules.each do |s|
        puts "ID: #{s.id} | Room: #{s.room_id} | Time: #{s.start_time.strftime('%I:%M %p')} - #{s.end_time.strftime('%I:%M %p')} | Date: #{s.start_date}"
      end
    end
    puts "------------------------------------------"


    relevant_schedules = Schedule.where(room_id: building.rooms.pluck(:id))
                               .where("start_date >= ? OR end_date >= ?", today, today)

    all_possible_times = []
    relevant_schedules.each do |s|
      all_possible_times << now.change(hour: s.start_time.hour, min: s.start_time.min)
      all_possible_times << now.change(hour: s.end_time.hour, min: s.end_time.min)
    end

    next_trigger = all_possible_times.select { |t| t > now }.min

    if next_trigger
      wait_seconds = (next_trigger - now).to_i
      puts "[SMART TRIGGER] Current Time: #{now.strftime('%I:%M %p')}"
      puts "[SMART TRIGGER] Next Change At: #{next_trigger.strftime('%I:%M %p')}"
      puts "[SMART TRIGGER] Action: Re-checking in #{wait_seconds} seconds."
    else
      puts "[SMART TRIGGER] No more events found for today."
    end

    next_trigger
  end
end
