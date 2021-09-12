class ReviewsController < ApplicationController
  def show
    @review = Review.find(params[:id])
    @user = User.find_by(id: @review.user_id)
  end

  def create
    @review = Review.new(review_params)
    puts review_params
    puts @review
    if @review.save
      flash[:success] = 'レビューを投稿しました。'
      redirect_to root_url
    else
      flash[:danger] = 'レビューの投稿に失敗しました。'
      redirect_to root_url
    end 
  end

  def destroy
  end
  
  private

  def review_params
    params.require(:review).permit(:score, :title, :text, :item_id).merge(user_id: current_user.id)
  end
end
