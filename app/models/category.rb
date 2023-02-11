class Category < ApplicationRecord
   has_many :photo_category_relations  #中間テーブルを先に記述しないとActiveRecord::HasManyThroughOrderErrorというエラーが発生
   has_many :photos, through: :photo_category_relations #中間テーブルのpost_category_relationsを経由して、関連付けをすることを意味している
   has_one_attached :image

   def get_image
     if image.attached?
        image
     else
      'no_image.png'
     end
   end
end

