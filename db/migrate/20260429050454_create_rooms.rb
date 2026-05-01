class CreateRooms < ActiveRecord::Migration[8.1]
  def change
    create_table :rooms do |t|
      t.string :name
      t.string :building
      t.integer :status

      t.timestamps
    end
  end
end
