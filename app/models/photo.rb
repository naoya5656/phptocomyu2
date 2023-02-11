class Photo < ApplicationRecord
  has_one_attached :image
  belongs_to :customer
  has_many :photo_category_relations #中間テーブルを先に記述しないとActiveRecord::HasManyThroughOrderErrorというエラーが発生
  has_many :categories, through: :photo_category_relations #中間テーブルのphoto_category_relationsを経由して、関連付けている。
  has_many :favorites
  has_many :photo_comments, dependent: :destroy


  def favorited_by?(customer)  #カスタマーidがfavoriteテーブル内に存在するかどうかを判別しているメソッド
      favorites.exists?(customer_id: customer.id)
  end

  def get_image
     if image.attached?
        image
     else
      'no_image.png'
     end
  end
end
