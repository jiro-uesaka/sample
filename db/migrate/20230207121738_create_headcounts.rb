class CreateHeadcounts < ActiveRecord::Migration[6.1]
  def change
    create_table :headcounts do |t|
      t.integer :shift_id
      t.integer :day
      t.integer :max_worker
      t.integer :min_worker

      t.timestamps
    end
  end
end
