# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.1].define(version: 2026_04_30_162043) do
  create_table "buildings", force: :cascade do |t|
    t.string "address"
    t.datetime "created_at", null: false
    t.string "name"
    t.datetime "updated_at", null: false
  end

  create_table "rooms", force: :cascade do |t|
    t.string "building"
    t.integer "building_id", null: false
    t.datetime "created_at", null: false
    t.string "name"
    t.integer "status"
    t.datetime "updated_at", null: false
    t.index ["building_id"], name: "index_rooms_on_building_id"
  end

  create_table "schedules", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.text "description"
    t.date "end_date"
    t.datetime "end_time"
    t.string "frequency", default: "once"
    t.integer "room_id", null: false
    t.date "start_date"
    t.datetime "start_time"
    t.string "status", default: "active"
    t.datetime "updated_at", null: false
    t.index ["room_id"], name: "index_schedules_on_room_id"
  end

  create_table "solid_cable_messages", force: :cascade do |t|
    t.binary "channel", limit: 1024, null: false
    t.integer "channel_hash", limit: 8, null: false
    t.datetime "created_at", null: false
    t.binary "payload", limit: 536870912, null: false
    t.index ["channel"], name: "index_solid_cable_messages_on_channel"
    t.index ["channel_hash"], name: "index_solid_cable_messages_on_channel_hash"
    t.index ["created_at"], name: "index_solid_cable_messages_on_created_at"
  end

  create_table "utilities", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "name"
    t.integer "room_id", null: false
    t.integer "status"
    t.datetime "updated_at", null: false
    t.string "utility_type"
    t.index ["room_id"], name: "index_utilities_on_room_id"
  end

  add_foreign_key "rooms", "buildings"
  add_foreign_key "schedules", "rooms"
  add_foreign_key "utilities", "rooms"
end
