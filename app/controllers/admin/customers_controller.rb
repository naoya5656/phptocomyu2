class Admin::CustomersController < ApplicationController
before_action :is_admin_access
before_action :authenticate_admin!

 def index
  @customers = Customer.all
 end
 
 def show
  @customer = Customer.find(params[:id])
  @photos = @customer.photos
 end
 
 def edit
   @customer = Customer.find(params[:id])
 end
 
 def update
  @customer = Customer.find(params[:id])
  if @customer.update(customer_params)
     redirect_to admin_customer_path(@customer)
     return
  else
     render :edit
  end
 end
 
 # フォロー一覧
  def followings
    @customer = Customer.find(params[:customer_id])
    @customers = @customer.followings
  end

  # フォロワー一覧
  def followers
    @customer = Customer.find(params[:customer_id])
    @customers = @customer.followers
  end
  
  
  def favorites
    @customer = Customer.find(params[:id])
    favorites = Favorite.where(customer_id: @customer.id).pluck(:photo_id) 
    @favorites_photos = Photo.find(favorites)
  end
  
  def destroy
    @customer = Customer.find(params[:id])
    @customer.destroy
    flash[:notice] = 'ユーザーを削除しました。'
    redirect_to admin_customers_path
  end
  
  private

  def customer_params
    params.require(:customer).permit(:name, :introduction, :profile_image, :is_deleted)
  end
end
     

