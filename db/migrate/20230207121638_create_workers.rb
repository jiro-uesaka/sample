class CreateWorkers < ActiveRecord::Migration[6.1]
  def change
    create_table :workers do |t|
      t.integer :shift_id
      t.integer :staff_id
      t.integer :holiday, default: 0
      t.integer :day1
      t.string :day1_note
      t.integer :day2
      t.string :day2_note
      t.integer :day3
      t.string :day3_note
      t.integer :day4
      t.string :day4_note
      t.integer :day5
      t.string :day5_note
      t.integer :day6
      t.string :day6_note
      t.integer :day7
      t.string :day7_note
      t.integer :day8
      t.string :day8_note
      t.integer :day9
      t.string :day9_note
      t.integer :day10
      t.string :day10_note
      t.integer :day11
      t.string :day11_note
      t.integer :day12
      t.string :day12_note
      t.integer :day13
      t.string :day13_note
      t.integer :day14
      t.string :day14_note
      t.integer :day15
      t.string :day15_note
      t.integer :day16
      t.string :day16_note
      t.integer :day17
      t.string :day17_note
      t.integer :day18
      t.string :day18_note
      t.integer :day19
      t.string :day19_note
      t.integer :day20
      t.string :day20_note
      t.integer :day21
      t.string :day21_note
      t.integer :day22
      t.string :day22_note
      t.integer :day23
      t.string :day23_note
      t.integer :day24
      t.string :day24_note
      t.integer :day25
      t.string :day25_note
      t.integer :day26
      t.string :day26_note
      t.integer :day27
      t.string :day27_note
      t.integer :day28
      t.string :day28_note
      t.integer :day29
      t.string :day29_note
      t.integer :day30
      t.string :day30_note
      t.integer :day31
      t.string :day31_note
      

      t.timestamps
    end
  end
end
