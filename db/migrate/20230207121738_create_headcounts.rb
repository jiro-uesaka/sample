class CreateHeadcounts < ActiveRecord::Migration[6.1]
  def change
    create_table :headcounts do |t|
      t.integer :shift_id
      t.integer :day1_max
      t.integer :day1_min
      t.integer :day2_max
      t.integer :day2_min
      t.integer :day3_max
      t.integer :day3_min
      t.integer :day4_max
      t.integer :day4_min
      t.integer :day5_max
      t.integer :day5_min
      t.integer :day6_max
      t.integer :day6_min
      t.integer :day7_max
      t.integer :day7_min
      t.integer :day8_max
      t.integer :day8_min
      t.integer :day9_max
      t.integer :day9_min
      t.integer :day10_max
      t.integer :day10_min
      t.integer :day11_max
      t.integer :day11_min
      t.integer :day12_max
      t.integer :day12_min
      t.integer :day13_max
      t.integer :day13_min
      t.integer :day14_max
      t.integer :day14_min
      t.integer :day15_max
      t.integer :day15_min
      t.integer :day16_max
      t.integer :day16_min
      t.integer :day17_max
      t.integer :day17_min
      t.integer :day18_max
      t.integer :day18_min
      t.integer :day19_max
      t.integer :day19_min
      t.integer :day20_max
      t.integer :day20_min
      t.integer :day21_max
      t.integer :day21_min
      t.integer :day22_max
      t.integer :day22_min
      t.integer :day23_max
      t.integer :day23_min
      t.integer :day24_max
      t.integer :day24_min
      t.integer :day25_max
      t.integer :day25_min
      t.integer :day26_max
      t.integer :day26_min
      t.integer :day27_max
      t.integer :day27_min
      t.integer :day28_max
      t.integer :day28_min
      t.integer :day29_max
      t.integer :day29_min
      t.integer :day30_max
      t.integer :day30_min
      t.integer :day31_max
      t.integer :day31_min
      

      t.timestamps
    end
  end
end
