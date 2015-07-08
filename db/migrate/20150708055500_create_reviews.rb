class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.string :subject
      t.string :content
      t.string :rating
      t.string :float
      t.integer :user_id
      t.integer :book_id

      t.timestamps null: false
    end
  end
end
