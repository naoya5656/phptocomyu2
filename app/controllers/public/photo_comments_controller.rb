class Public::PhotoCommentsController < ApplicationController

  def create
    photo = Photo.find(params[:photo_id])
    @photo_comment = current_customer.photo_comments.new(photo_comment_params)
    @photo_comment.photo_id = photo.id
    @photo_comment.save
    redirect_to photo_path(photo)
  end

  def destroy
    photo = Photo.find(params[:photo_id])
    @photo_comment = PhotoComment.find(params[:id])
    @photo_comment.destroy
    redirect_to photo_path(photo)
  end


  private
  def photo_comment_params
    params.require(:photo_comment).permit(:comment)
  end
end
