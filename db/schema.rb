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

ActiveRecord::Schema.define(version: 2023_02_07_154948) do

  create_table "headcounts", force: :cascade do |t|
    t.integer "shift_id"
    t.integer "day"
    t.integer "max_worker"
    t.integer "min_worker"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "shifts", force: :cascade do |t|
    t.integer "user_id"
    t.integer "shop_id"
    t.integer "year"
    t.integer "month"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "shops", force: :cascade do |t|
    t.integer "user_id"
    t.string "name"
    t.integer "max_worker"
    t.integer "min_worker"
    t.integer "holiday"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "staffs", force: :cascade do |t|
    t.integer "user_id"
    t.string "name"
    t.integer "holiday"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "work_patterns", force: :cascade do |t|
    t.integer "user_id"
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "workers", force: :cascade do |t|
    t.integer "shift_id"
    t.integer "staff_id"
    t.integer "day1"
    t.string "day1_note"
    t.integer "day2"
    t.string "day2_note"
    t.integer "day3"
    t.string "day3_note"
    t.integer "day4"
    t.string "day4_note"
    t.integer "day5"
    t.string "day5_note"
    t.integer "day6"
    t.string "day6_note"
    t.integer "day7"
    t.string "day7_note"
    t.integer "day8"
    t.string "day8_note"
    t.integer "day9"
    t.string "day9_note"
    t.integer "day10"
    t.string "day10_note"
    t.integer "day11"
    t.string "day11_note"
    t.integer "day12"
    t.string "day12_note"
    t.integer "day13"
    t.string "day13_note"
    t.integer "day14"
    t.string "day14_note"
    t.integer "day15"
    t.string "day15_note"
    t.integer "day16"
    t.string "day16_note"
    t.integer "day17"
    t.string "day17_note"
    t.integer "day18"
    t.string "day18_note"
    t.integer "day19"
    t.string "day19_note"
    t.integer "day20"
    t.string "day20_note"
    t.integer "day21"
    t.string "day21_note"
    t.integer "day22"
    t.string "day22_note"
    t.integer "day23"
    t.string "day23_note"
    t.integer "day24"
    t.string "day24_note"
    t.integer "day25"
    t.string "day25_note"
    t.integer "day26"
    t.string "day26_note"
    t.integer "day27"
    t.string "day27_note"
    t.integer "day28"
    t.string "day28_note"
    t.integer "day29"
    t.string "day29_note"
    t.integer "day30"
    t.string "day30_note"
    t.integer "day31"
    t.string "day31_note"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

end
