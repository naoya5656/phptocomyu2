class Admin::PhotosController < ApplicationController
    
    def index
      @photos = Photo.all
    end
    
    def show
      @photo = Photo.find(params[:id])
    end
    
    def destroy
    @photo = Photo.find(params[:id])
    @photo.destroy
    redirect_to photos_path
  end
    
end
