class RemoveCategoryIdFromPhotos < ActiveRecord::Migration[6.1]
  def change
    remove_column :photos, :category_id, :integer
  end
end
