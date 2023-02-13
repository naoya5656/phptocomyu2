class Public::FavoritesController < ApplicationController

  def create
  @photo = Photo.find(params[:photo_id])
  favorite = current_customer.favorites.new(photo_id: @photo.id)
  favorite.save
  render :favorites_btn

  end

  def destroy
  @photo = Photo.find(params[:photo_id])
  favorite = current_customer.favorites.find_by(photo_id: @photo.id) #find_byはモデルの主キー以外の条件でも、レコードを取得することができるメソッド
  favorite.destroy
  render :favorites_btn

  end
end
