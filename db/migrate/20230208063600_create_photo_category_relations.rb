class CreatePhotoCategoryRelations < ActiveRecord::Migration[6.1]
  def change
    create_table :photo_category_relations do |t|
      t.integer :photo_id
      t.integer :category_id
      t.timestamps
    end
  end
end
