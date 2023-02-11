class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

         has_one_attached :profile_image
         has_many :photos, dependent: :destroy
         has_many :favorites, dependent: :destroy
         has_many :photo_comments, dependent: :destroy


  def get_profile_image(width, height)
  unless profile_image.attached?
         file_path = Rails.root.join('app/assets/images/no_image.jpg') #画像がない場合の代用画像
         profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
  end
         profile_image.variant(resize_to_limit: [width, height]).processed
  end
end
