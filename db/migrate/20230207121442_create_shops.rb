class CreateShops < ActiveRecord::Migration[6.1]
  def change
    create_table :shops do |t|
      t.integer :user_id
      t.string :name
      t.integer :max_worker
      t.integer :min_worker
      t.integer :holiday

      t.timestamps
    end
  end
end
