class Admin::PhotosController < ApplicationController
    before_action :is_admin_access
    before_action :authenticate_admin!
    def index
      @photos = Photo.all
    end
    
    def show
      @photo = Photo.find(params[:id])
    end
    
    def destroy
    @photo = Photo.find(params[:id])
    @photo.destroy
    redirect_to admin_photos_path
    end
    
    
end
