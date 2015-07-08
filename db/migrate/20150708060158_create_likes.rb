class CreateLikes < ActiveRecord::Migration
  def change
    create_table :likes do |t|
      t.integer :status
      t.integer :user_id
      t.integer :activity_id

      t.timestamps null: false
    end
  end
end
