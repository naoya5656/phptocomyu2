class Public::CustomersController < ApplicationController

  def show
    @customer = Customer.find(params[:id])
    @photos = @customer.photos
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

  private

  def customer_params
    params.require(:customer).permit(:name, :profile_image)
  end
end
