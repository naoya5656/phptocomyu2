class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

         has_one_attached :profile_image
         has_many :photos, dependent: :destroy
         has_many :favorites, dependent: :destroy
         has_many :photo_comments, dependent: :destroy

         #フォローした、されたの関係
         has_many :follows, class_name: "Follow", foreign_key: "follower_id", dependent: :destroy
         has_many :followeds, class_name: "Follow", foreign_key: "followed_id", dependent: :destroy

         #フォロー表示
         has_many :followings, through: :follows, source: :followed

         #フォロワー表示
         has_many :followers, through: :followeds, source: :follower
         
         validates :name, length: {in: 1..20}, uniqueness: true
         
         def active_for_authentication?    # is_deletedがfalseならtrueを返すようにしている(ログイン時に退会済みのユーザーが同じアカウントでログイン出来ないよう制約)
             super && (is_deleted == false)
         end
         
         
         def self.guest
           find_or_create_by!(email: 'aaa@aaa.com') do |customer| #find_or_create_byはデータの検索と作成を自動的に判断して処理を行う、Railsのメソッド
           customer.password = SecureRandom.urlsafe_base64 #SecureRandom.urlsafe_base64はランダムな文字列を生成するRubyのメソッド
           customer.password_confirmation = customer.password
           customer.name = 'ゲスト'
           end
         end

         #フォローした時の処理
         def follow(customer_id)
           follows.create(followed_id: customer_id)
         end

         #フォローを外すときの処理
         def unfollow(customer_id)
           follows.find_by(followed_id: customer_id).destroy
         end

         #フォローしているかの判定
         def followings?(customer)
         followings.include?(customer)
         end

         def self.looks(search, word)  #{word}に%を付けた位置で検索場所が変更できる
           if search == "perfect_match"
              @customer = Customer.where("name LIKE?", "#{word}")  #完全一致
           elsif search == "forward_match"
              @customerr = Customer.where("name LIKE?","#{word}%")  #前方一致
           elsif search == "backward_match"
              @customer = Customer.where("name LIKE?","%#{word}")  #後方一致
           elsif search == "partial_match"
              @customer = Customer.where("name LIKE?","%#{word}%")  #部分一致
           else
              @customer = Customer.all
           end
         end

  def get_profile_image(width, height)
  unless profile_image.attached?
         file_path = Rails.root.join('app/assets/images/no_image.jpg') #画像がない場合の代用画像
         profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
  end
         profile_image.variant(resize_to_limit: [width, height]).processed
  end
end
