class CustomerAddressesController < ApplicationController
  before_action :authorize_user, only: [:index, :destroy]
  before_action :authenticate_customer!, only: [:new, :create, :show, :edit, :update]

  def new 
    @cart = current_cart
    @cart.shipping = nil
    @cart.save
    if @cart.order_items.empty?
      redirect_to root_url, notice: "Your cart is empty"
      return
    end
    # @order = Order.new
    @customer_address = CustomerAddress.new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @order }
    end
  end

  def create
    @order = Order.new
    @order.customer = current_customer
    # current_cart.customer = current_customer
    @order.add_order_items_from_cart(current_cart)
    @customer_address = @order.build_customer_address(customer_address_params)
    @customer_address.customer = current_customer
    respond_to do |format|
      if @customer_address.save
        # if session[:cart_id].present?
        #   Cart.destroy(session[:cart_id])
        #   session[:cart_id] = nil
        # end
        format.html { redirect_to payments_new_path(order_id: @order.id) }
        format.json { render json: @customer_address, status: :created,
          location: @customer_address }
      else
        @cart = current_cart
        format.html { render action: "new" }
        format.json { render json: @customer_address.errors,
          status: :unprocessable_entity }
      end
    end
  end

  def edit
    @customer_address = CustomerAddress.find(params[:id])
  end

  def update
    @customer_address = CustomerAddress.find(params[:id])
    respond_to do |format|
      if @customer_address.update_attributes(customer_address_params)
        format.html { redirect_to payments_new_path(order_id: @customer_address.order.id) }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @customer_address.errors, status: :unprocessable_entity }
      end
    end
  end

  private
  def customer_address_params
    params.require(:customer_address).permit(:address1, :address2, :city, :district, :state, :country, :pincode, :contact_details)
  end
end