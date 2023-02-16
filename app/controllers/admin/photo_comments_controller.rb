class Admin::PhotoCommentsController < ApplicationController
    
    def destroy
    photo = Photo.find(params[:photo_id])
    @photo_comment = PhotoComment.find(params[:id])
    @photo_comment.destroy
    render :comment_destroy
    end
end
