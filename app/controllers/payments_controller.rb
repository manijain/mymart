class PaymentsController < ApplicationController
  before_action :authenticate_customer!, only: [:new, :checkout]

  def new
    @customer_address = CustomerAddress.find(params[:address_id])
    @cart = current_cart
    @total = 0.0
    @cart.order_items.each do |item|
      @total += item.item_quantity * item.product.price
    end
    @client_token = Braintree::ClientToken.generate
  end

  def checkout
    @customer_address = CustomerAddress.find(params[:address_id])
    if @customer_address.order.present?
      @order = Order.find(@customer_address.order.id)
    else
      @order = Order.new
    end 
    
    @order.add_order_items_from_cart(current_cart)
    @order.customer = current_customer
    cart = current_cart
    @order.shipping = cart.shipping
    @order.save
    
    @customer_address.order = @order
    @customer_address.save

    total_price = params[:total_price]
    # @order = Order.find(params[:order_id])

    nonce_from_the_client = params[:payment_method_nonce]
    result = Braintree::Transaction.sale(
      :amount => total_price,
      :payment_method_nonce => nonce_from_the_client,
      :options => {
      :submit_for_settlement => true
    })
    # response = {:success => result.success?}
    respond_to do |format|
      if result.success?
        @order.update_attributes(status: "1")
        OrderItem.where('cart_id = ?', current_cart.id).update_all(cart_id: nil)
        # Cart.where('customer_id = ?', current_customer.id).update_all(customer_id: nil)
        # Cart.where('customer_id = ?', current_customer.id).delete_all
        if session[:cart_id].present?
          Cart.destroy(session[:cart_id])
          session[:cart_id] = nil
        end
        puts "success --- #{result.transaction.id}"
        # response[:transaction_id] = result.transaction.id
        format.html { redirect_to order_path(@order), notice: 'Your order successfully placed.' }
        format.json { head :no_content }
      elsif result.transaction
        @order.update_attributes(status: "0")
        puts "Error Processiong Transaction"
        # response[:error] = result.transaction.processor_response_text
        # format.html { render :action => 'new', alert: result.transaction.processor_response_text } 
        format.html { redirect_to payments_new_path(address_id: @customer_address.id), alert: result.transaction.processor_response_text }
        format.json { head :no_content }
      else
        @order.update_attributes(status: "0")
        puts result.errors
        # response[:error] = result.errors.inspect
        # format.html { render :action => 'new', alert: result.errors.map(&:message).join(",") } 
        format.html { redirect_to payments_new_path(address_id: @customer_address.id), alert: result.errors.map(&:message).join(",") }
        format.json { head :no_content }
      end
    end
    # render :json => response
  end
end