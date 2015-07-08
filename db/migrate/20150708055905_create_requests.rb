class CreateRequests < ActiveRecord::Migration
  def change
    create_table :requests do |t|
      t.string :book_name
      t.string :author
      t.string :description
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
