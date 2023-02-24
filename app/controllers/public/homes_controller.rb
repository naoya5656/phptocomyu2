class Public::HomesController < ApplicationController
  def top
    @photos = Photo.all.order("id DESC")
    @photo = Photo.order(created_at: :desc).limit(4)
  end

  def about
  end
end
