class ProductsController < ApplicationController
  before_action :authorize_user, only: [:destroy, :update, :create, :edit, :index]

  def new
    @product = Product.new
  end

  def index
    @products = Product.all.paginate(:page => params[:page])
  end

  def create
  	@product = Product.new(product_params)
  	respond_to do |format|
      if @product.save
        format.html { redirect_to product_path(@product), notice: 'Product successfully created.' }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
    @product = Product.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @product }
    end
  end

  def edit
    @product = Product.find(params[:id])
  end

  def update
    @product = Product.find(params[:id])
    respond_to do |format|
      if @product.update_attributes(product_params)
        format.html { redirect_to product_path(@product), :notice => "Product successfully updated." }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    def product_params
      params.require(:product).permit(:title, :description, :price, :quantity, :picture)
    end
end