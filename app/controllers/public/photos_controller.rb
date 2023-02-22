class Public::PhotosController < ApplicationController

  def new
    @photo = Photo.new
  end

  def create
    @photo = Photo.new(photo_params)
    @photo.customer_id = current_customer.id
    if @photo.save
      flash[:success] = "投稿に成功しました"
    redirect_to photos_path
    else
    render :new
    end
  end

  def index
    @photos = Photo.all.order(created_at: :DESC)
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
    flash[:success] = "投稿を変更しました"
    redirect_to photo_path(@photo)
    else
    render :edit
    end
  end

  def destroy
    @photo = Photo.find(params[:id])
    @photo.destroy
    flash[:danger] = "投稿を削除しました"
    redirect_to photos_path
  end


  private
  def photo_params
    params.require(:photo).permit(:name, :body, :image, category_ids: []) #category_ids: [] 投稿に紐付くカテゴリは、チェックボックスによって複数渡される場合があるため、配列形式であることを記載
  end
  
  def is_matching_login_user
    photo = Photo.find(params[:id])
    customer_id = photo.customer.id
    unless user_id == current_customer.id
      redirect_to photos_path
    end
   end
end
