class ProductsController < InheritedResources::Base
  before_filter :authorize_user

  def index
    @products = Product.all.paginate(:page => params[:page])
  end

  def create
  	debugger
  	@product = Product.new(product_params)
  	respond_to do |format|
      if @product.save
        format.html { redirect_to product_path(@product), notice: 'Product was successfully created.' }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    def product_params
      params.require(:product).permit(:title, :description, :price, :quantity, :picture)
    end
end