class ReviewsController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:destroy]
  
  def show
    @review = Review.find(params[:id])
    @user = User.find_by(id: @review.user_id)
    @item = Item.find_by(id: @review.item_id)
    @item_user = User.find_by(id: @item.user_id)
  end

  def create
    @review = Review.new(review_params)
    if @review.save
      flash[:success] = 'レビューを投稿しました。'
      redirect_to root_url
    else
      flash[:danger] = 'レビューの投稿に失敗しました。'
      redirect_to root_url
    end 
  end

  def destroy
    @correct_review.destroy
      flash[:success] = '投稿を削除しました。'
      redirect_back(fallback_location: root_path)
  end
  
  private

  def review_params
    params.require(:review).permit(:score, :title, :text, :item_id).merge(user_id: current_user.id)
  end
  
  def correct_user
    @correct_review = current_user.reviews.find_by(id: params[:id])
    unless @correct_review
      redirect_to root_url
    end
  end
end
