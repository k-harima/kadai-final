class ToppagesController < ApplicationController
  def index
    if logged_in?
      @pagy, @items = pagy(Item.all.order(id: :desc))
    end
  end
end
