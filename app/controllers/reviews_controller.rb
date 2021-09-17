class ReviewsController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:destroy]
  before_action :already_item_review?, only: [:new, :create]
  
  def show
    @review = Review.find(params[:id])
    @user = User.find_by(id: @review.user_id)
    @item = Item.find_by(id: params[:item_id])
    @item_user = User.find_by(id: @item.user_id)
  end
  
  def new
    @item = Item.find_by(id: params[:item_id])
    @user = User.find_by(id: @item.user_id)
    @review = @item.reviews.build()
    @item_id = params[:item_id]
  end

  def create
    @item = Item.find_by(id: params[:item_id])
    @user = User.find_by(id: @item.user_id)
    @review = @item.reviews.build(review_params)
    if @review.save
      flash[:success] = 'レビューを投稿しました。'
      redirect_to item_review_path(@item, @review)
    else
      flash.now[:danger] = 'レビューの投稿に失敗しました'
      render :new
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
    params.require(:review).permit(:score, :title, :text).merge(user_id: current_user.id)
  end
  
  def correct_user
    @correct_review = current_user.reviews.find_by(id: params[:id])
    unless @correct_review
      redirect_to root_url
    end
  end
  
  def already_item_review?
    @already_item = current_user.reviews.find_by(item_id: params[:item_id])
    if @already_item
      redirect_to root_url
    end
  end
end
