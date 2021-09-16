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
      redirect_to review_path(@review)
    else
      flash[:danger] = 'レビューの投稿に失敗しました。内容に不備があるのでご確認ください。<br>・すべてのフォームに入力してください<br>・タイトルは20文字以内に収めてください。<br>・レビューは500文字以内に収めてください。'
      redirect_to new_reviews_item_path(id: review_params[:item_id])
    end 
  end

  def destroy
    @item_id = @correct_review.item_id
    @correct_review.destroy
      flash[:success] = '投稿を削除しました。'
      redirect_to item_path(@item_id)
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
