class Public::CustomersController < ApplicationController
    before_action :is_matching_login_customer, only: [:edit, :update]
  def show
    @customer = Customer.find(params[:id])
    @photos = @customer.photos
  end
  
  def index
    @customers = Customers.all
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def update
  @customer =Customer.find(params[:id])
  @customer.update(customer_params)
  redirect_to customer_path(current_customer)
  end
  
  def favorites
    @customer = Customer.find(params[:id])
    favorites = Favorite.where(customer_id: @customer.id).pluck(:photo_id) 
    @favorites_photos = Photo.find(favorites)
  end
  
  def withdrawal
    @customer = Customer.find(params[:id])
    @customer.update(is_deleted: true)  # is_deletedカラムをtrueに変更することにより削除フラグを立てる
    reset_session
    flash[:notice] = "退会処理を実行いたしました"
    redirect_to root_path
  end

  private

  def customer_params
    params.require(:customer).permit(:name, :profile_image)
  end
  
  def is_matching_login_customer   
    customer_id = params[:id].to_i
    unless customer_id == current_customer.id    
      redirect_to customer_path(current_customer) 
    end
  end
end
