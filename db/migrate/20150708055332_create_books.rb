class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.string :title
      t.string :publish_date
      t.string :author
      t.integer :number_page
      t.float :rate
      t.string :content
      t.string :picture

      t.timestamps null: false
    end
  end
end
