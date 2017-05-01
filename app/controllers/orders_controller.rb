class OrdersController < ApplicationController
  before_action :authorize_user, only: [:index, :destroy, :update, :edit]
  before_action :authenticate_customer!, only: [:new, :create, :show, :my_orders]

  def index
    @orders = Order.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @orders }
    end
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
    @order = Order.find(params[:id])
    # Cart.destroy(session[:cart_id])
    # session[:cart_id] = nil

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @order }
    end
  end

  # GET /orders/new
  # GET /orders/new.json
  def new
    @cart = current_cart
    if @cart.order_items.empty?
      redirect_to root_url, notice: "Your cart is empty"
      return
    end

    @order = Order.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @order }
    end
  end

  # GET /orders/1/edit
  def edit
    @order = Order.find(params[:id])
  end

  # POST /orders
  # POST /orders.json
  def create
    @order = Order.new(order_params)
    @order.customer = current_customer

    @order.add_order_items_from_cart(current_cart)

    respond_to do |format|
      if @order.save
        # Cart.destroy(session[:cart_id])
        # session[:cart_id] = nil
        format.html { redirect_to payments_new_path(order_id: @order.id) }
        format.json { render json: @order, status: :created,
          location: @order }
      else
        @cart = current_cart
        format.html { render action: "new" }
        format.json { render json: @order.errors,
          status: :unprocessable_entity }
      end
    end
  end

  # PUT /orders/1
  # PUT /orders/1.json
  def update
    @order = Order.find(params[:id])

    respond_to do |format|
      if @order.update_attributes(order_params)
        format.html { redirect_to @order, notice: 'Order was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    @order = Order.find(params[:id])
    @order.destroy

    respond_to do |format|
      format.html { redirect_to orders_url }
      format.json { head :no_content }
    end
  end

  def my_orders
    @customer_orders = current_customer.orders
  end

  private
    def order_params
      params.require(:order).permit(:name, :address, :email, :pay_type)
    end
end