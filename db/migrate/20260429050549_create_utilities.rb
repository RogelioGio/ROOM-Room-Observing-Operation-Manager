class CreateUtilities < ActiveRecord::Migration[8.1]
  def change
    create_table :utilities do |t|
      t.string :name
      t.string :utility_type
      t.references :room, null: false, foreign_key: true

      t.timestamps
    end
  end
end
