class CreateShifts < ActiveRecord::Migration[6.1]
  def change
    create_table :shifts do |t|
      t.integer :user_id
      t.integer :shop_id
      t.integer :year
      t.integer :month

      t.timestamps
    end
  end
end
