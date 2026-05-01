class AddDescriptionToSchedules < ActiveRecord::Migration[8.1]
  def change
    add_column :schedules, :description, :text
  end
end
