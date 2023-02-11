class Public::PhotosController < ApplicationController

  def new
    @photo = Photo.new
  end

  def create
    @photo = Photo.new(photo_params)
    @photo.customer_id = current_customer.id
    @photo.save
    redirect_to photos_path
  end

  def index
    @photos = Photo.all
  end

  def show
    @photo = Photo.find(params[:id])
    @photo_comment = PhotoComment.new
  end

  def edit
    @photo = Photo.find(params[:id])
  end

  def update
    @photo = Photo.find(params[:id])
    if @photo.update(photo_params)
    flash[:notice] = "変更しました"
    redirect_to photo_path(@photo)
    else
    render :edit
    end
  end

  def destroy
    @photo = Photo.find(params[:id])
    @photo.destroy
    redirect_to photos_path
  end


  private
  def photo_params
    params.require(:photo).permit(:name, :body, :image, category_ids: []) #category_ids: [] 投稿に紐付くカテゴリは、チェックボックスによって複数渡される場合があるため、配列形式であることを記載
  end
end
