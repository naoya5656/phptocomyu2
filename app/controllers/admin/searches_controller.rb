class Admin::SearchesController < ApplicationController
    
  def search
    @range = params[:range]

    if @range == "ユーザー名"
      @customers = Customer.looks(params[:search], params[:word])
      render 'admin/searches/search_result'
    else
      @photos = Photo.looks(params[:search], params[:word])
      render 'admin/searches/search_result'
    end
  end
end
