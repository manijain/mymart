class OrderItemsController < ApplicationController

  def index
    @order_items = OrderItem.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @order_items }
    end
  end

  def show
    @order_item = OrderItem.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @order_item }
    end
  end

  def new
    @order_item = OrderItem.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @order_item }
    end
  end

  def edit
    @order_item = OrderItem.find(params[:id])
  end


  def create
    @cart = current_cart
    product = Product.find(params[:product_id])
    @order_item = @cart.add_product(product.id)
    # @order_item = @cart.order_items.build
    @order_item.product = product

    respond_to do |format|
      if @order_item.save
        format.html { redirect_to root_url,
          notice: 'Order Items was successfully created.' }
        format.js {  @current_item = @order_item }
        format.json { render json: @order_item,
          status: :created, location: @order_item }
      else
        format.html { render action: "new" }
        format.json { render json: @order_item.errors,
          status: :unprocessable_entity }
      end
    end
  end

  def update
    @order_item = OrderItem.find(params[:id])

    respond_to do |format|
      if @order_item.update_attributes(params[:order_item])
        format.html { redirect_to @order_item, notice: 'Order Items was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @order_item.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @order_item = OrderItem.find(params[:id])
    @order_item.destroy

    respond_to do |format|
      format.html { redirect_to order_items_url }
      format.json { head :no_content }
    end
  end

  def add_quantity
    if params[:order_item_id].present?
      order_item = OrderItem.find(params[:order_item_id])
      order_item.item_quantity += 1
      order_item.save
      @cart = order_item.cart
    end
    respond_to do |format|
      format.html { redirect_to new_customer_address_path }
      format.js { }
    end
  end

  def less_quantity
    if params[:order_item_id].present?
      order_item = OrderItem.find(params[:order_item_id])
      if order_item.item_quantity > 1
        order_item.item_quantity -= 1
        order_item.save
      end
      @cart = order_item.cart
    end
    respond_to do |format|
      format.html { redirect_to new_customer_address_path }
      format.js { }
    end
  end
end