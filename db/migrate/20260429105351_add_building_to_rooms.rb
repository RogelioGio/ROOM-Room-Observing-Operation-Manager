class AddBuildingToRooms < ActiveRecord::Migration[8.1]
  def change
    add_reference :rooms, :building, null: false, foreign_key: true
  end
end
