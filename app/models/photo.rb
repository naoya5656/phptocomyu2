class Photo < ApplicationRecord
  has_one_attached :image
  belongs_to :customer
  has_many :photo_category_relations #中間テーブルを先に記述しないとActiveRecord::HasManyThroughOrderErrorというエラーが発生
  has_many :categories, through: :photo_category_relations #中間テーブルのphoto_category_relationsを経由して、関連付けている。
  has_many :favorites, dependent: :destroy 
  has_many :photo_comments, dependent: :destroy

  validates :image, presence: true
  validates :name, presence: true
  validates :body, length:{maximum:100}


  def favorited_by?(customer)  #カスタマーidがfavoriteテーブル内に存在するかどうかを判別しているメソッド
      favorites.exists?(customer_id: customer.id)
  end

  def self.looks(search, word)     #{word}に%を付けた位置で検索場所が変更できる
    if search == "perfect_match"
      @photo = Photo.where("name LIKE?","#{word}") #完全一致
    elsif search == "forward_match"
      @photo = Photo.where("name LIKE?","#{word}%") #前方一致
    elsif search == "backward_match"
      @photo = Photo.where("name LIKE?","%#{word}") #後方一致
    elsif search == "partial_match"
      @photo = Photo.where("name LIKE?","%#{word}%") #部分一致
    else
      @photo = Photo.all
    end
  end

  def get_image
     if image.attached?
        image
     else
      'no_image.png'
     end
  end
end
