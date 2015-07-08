class CreateReadings < ActiveRecord::Migration
  def change
    create_table :readings do |t|
      t.integer :status
      t.integer :user_id
      t.integer :book_id

      t.timestamps null: false
    end
  end
end
