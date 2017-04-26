class ProductsController < InheritedResources::Base
  def index
    @products = Product.all.paginate(:page => params[:page])
  end

  private

    def product_params
      params.require(:product).permit(:title, :description, :price, :quantity, :picture)
    end
end

