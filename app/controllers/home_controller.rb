class HomeController < ApplicationController
  def index
    @products = Product.all.paginate(:page => params[:page])
  end
end
