class Public::CustomersController < ApplicationController
    before_action :is_matching_login_customer, only: [:edit, :update]
    before_action :ensure_guest_customer, only: [:edit]
    
  def show
    @customer = Customer.find(params[:id])
    @photos = @customer.photos.order(created_at: :DESC)
  end
  
  def index
    @customers = Customer.all.order(created_at: :DESC).page(params[:page])
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def update
    @customer = Customer.find(params[:id])
    if @customer.update(customer_params)
      flash[:success] = "プロフィールを変更しました"
      redirect_to customer_path(@customer)
      return
    else
      render :edit
      return
    end
    if admin_signed_in?
      redirect_to admin_customer_path(@customer)
      return
    else
      redirect_to customer_path(current_customer)
    end
  end
  
  def favorites
    @customer = Customer.find(params[:id])
    favorites = Favorite.where(customer_id: @customer.id).pluck(:photo_id) 
    @favorites_photos = Photo.find(favorites)
  end
  
  def withdrawal
    @customer = current_customer
    @customer.update(is_deleted: true)  # is_deletedカラムをtrueに変更することにより削除フラグを立てる
    reset_session
    flash[:notice] = "退会処理を実行いたしました"
    redirect_to root_path
  end

  private

  def customer_params
    params.require(:customer).permit(:name, :introduction, :profile_image)
  end
  
  def is_matching_login_customer   
    customer_id = params[:id].to_i
    if admin_signed_in?
      return
    end
    unless customer_id == current_customer.id    
      redirect_to customer_path(current_customer) 
    end
  end
  
  def ensure_guest_customer
    @customer = Customer.find(params[:id])
    if @customer.name == "ゲスト"
      flash[:danger] = 'ゲストユーザーはプロフィール編集画面へ遷移できません。'
      redirect_to customer_path(current_customer)
    end
  end  
end
