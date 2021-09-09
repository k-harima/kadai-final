class ToppagesController < ApplicationController
  def index
    if logged_in?
      @item = current_user.items.build  # form_with 用
      @pagy, @items = pagy(current_user.items.order(id: :desc))
    end
  end
end
