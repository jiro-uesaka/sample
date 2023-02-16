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
    t.integer "day1_max"
    t.integer "day1_min"
    t.integer "day2_max"
    t.integer "day2_min"
    t.integer "day3_max"
    t.integer "day3_min"
    t.integer "day4_max"
    t.integer "day4_min"
    t.integer "day5_max"
    t.integer "day5_min"
    t.integer "day6_max"
    t.integer "day6_min"
    t.integer "day7_max"
    t.integer "day7_min"
    t.integer "day8_max"
    t.integer "day8_min"
    t.integer "day9_max"
    t.integer "day9_min"
    t.integer "day10_max"
    t.integer "day10_min"
    t.integer "day11_max"
    t.integer "day11_min"
    t.integer "day12_max"
    t.integer "day12_min"
    t.integer "day13_max"
    t.integer "day13_min"
    t.integer "day14_max"
    t.integer "day14_min"
    t.integer "day15_max"
    t.integer "day15_min"
    t.integer "day16_max"
    t.integer "day16_min"
    t.integer "day17_max"
    t.integer "day17_min"
    t.integer "day18_max"
    t.integer "day18_min"
    t.integer "day19_max"
    t.integer "day19_min"
    t.integer "day20_max"
    t.integer "day20_min"
    t.integer "day21_max"
    t.integer "day21_min"
    t.integer "day22_max"
    t.integer "day22_min"
    t.integer "day23_max"
    t.integer "day23_min"
    t.integer "day24_max"
    t.integer "day24_min"
    t.integer "day25_max"
    t.integer "day25_min"
    t.integer "day26_max"
    t.integer "day26_min"
    t.integer "day27_max"
    t.integer "day27_min"
    t.integer "day28_max"
    t.integer "day28_min"
    t.integer "day29_max"
    t.integer "day29_min"
    t.integer "day30_max"
    t.integer "day30_min"
    t.integer "day31_max"
    t.integer "day31_min"
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
    t.integer "holiday", default: 0
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
    t.integer "holiday", default: 0
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
