class FavoritesController < ApplicationController
  before_action :require_user_logged_in
  
  def create
    item = Item.find(params[:item_id])
    current_user.favorite(item)
    flash[:success] = ' 投稿をお気に入りしました。'
    redirect_to likes_user_path(current_user)
  end

  def destroy
    item = Item.find(params[:item_id])
    current_user.unfavorite(item)
    flash[:success] = 'お気に入りを解除しました。'
    redirect_to likes_user_path(current_user)
  end
end
