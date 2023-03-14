class Public::RanksController < ApplicationController
def rank
    @photos = Photo.includes(:favorited_customers).sort {|a,b| b.favorited_customers.size <=> a.favorited_customers.size}
#Favoriteモデルのphoto_idが同じものでまとめて
#それをphoto_idの多い順に並び替えて、photo_idを取り出す
#Photoモデルからいいね順に投稿を取得する
end
end
