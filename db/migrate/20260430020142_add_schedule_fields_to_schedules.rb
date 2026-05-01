class AddScheduleFieldsToSchedules < ActiveRecord::Migration[8.1]
  def change
    add_column :schedules, :start_date, :date
    add_column :schedules, :end_date, :date
    add_column :schedules, :frequency, :string, default: 'once'
    add_column :schedules, :status, :string, default: 'active'
  end
end
