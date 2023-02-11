class CreatePhotos < ActiveRecord::Migration[6.1]
  def change
    create_table :photos do |t|
      t.string :name, null: false
      t.text :body
      t.integer :category_id, null: false
      t.integer :customer_id, null: false
      t.timestamps
    end
  end
end
