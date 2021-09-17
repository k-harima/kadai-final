class ItemsController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:destroy]
  
  def show
    @item = Item.find(params[:id])
    @user = User.find(@item.user_id)
    @pagy, @reviews = pagy(@item.reviews.order(id: :desc))
  end

  def new
    @item = current_user.items.build()
  end

  def create
    @item = current_user.items.build(item_params)
    
    if @item.save
      flash[:success] = '商品を投稿しました。'
      redirect_to root_url
    else
      @pagy, @items = pagy(current_user.items.order(id: :desc))
      flash.now[:danger] = '商品の投稿に失敗しました。'
      render 'items/new'
    end
  end

  def destroy
    @item.destroy
    flash[:success] = '投稿を削除しました。'
    redirect_back(fallback_location: root_path)
  end
  
  def search
    if params[:name].present?
      @pagy,@searchs = pagy(Item.where('name LIKE ?', "%#{params[:name]}%").order(id: :desc))
    else
      @searchs = Item.none
    end
  end
  
  private

  def item_params
    params.require(:item).permit(:name, :company, :price, :picture)
  end

  def correct_user
    @item = current_user.items.find_by(id: params[:id])
    unless @item
      redirect_to root_url
    end
  end
end
