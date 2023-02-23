class Admin::CategoriesController < ApplicationController
  

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
    flash[:success] = "カテゴリーを追加しました"
    redirect_to admin_categories_path
    else
    render :new
    end
  end

  def index
    @categories = Category.all
  end

  def show
    @category = Category.find(params[:id])
    @photos = @category.photos.order(created_at: :DESC).page(params[:page])
  end
  
  def edit
    @category = Category.find(params[:id])
  end
  
  def update
    @category = Category.find(params[:id])
    if @category.update(category_params)
    flash[:success] = "カテゴリーを変更しました"
    redirect_to admin_categories_path(@category)
    else
    render :edit
    end
  end
  
  def destroy
    @category = Category.find(params[:id])
    @category.destroy
    flash[:danger] = "カテゴリーを削除しました"
    redirect_to admin_categories_path
  end
  
  
  private
  def category_params
    params.require(:category).permit(:name, :image)
  end
  
end
