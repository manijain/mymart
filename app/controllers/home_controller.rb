class HomeController < ApplicationController
  def index
    # @products = Product.all.paginate(:page => params[:page])
    @products = Product.order(:title).paginate(:page => params[:page])
    @cart = current_cart
  end
end