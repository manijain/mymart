class PaymentsController < ApplicationController
  before_action :authenticate_customer!, only: [:new, :checkout]

  def new
    @order = Order.find(params[:order_id])
    @total = 0.0
    @order.order_items.each do |item|
      @total += item.item_quantity * item.product.price
    end
    @cart = current_cart
    @client_token = Braintree::ClientToken.generate
  end

  def checkout
    total_price = params[:total_price]
    @order = Order.find(params[:order_id])

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
        OrderItem.where('cart_id = ?', current_cart.id).update_all(cart_id: nil)
        # current_cart.order_items.delete_all
        Cart.destroy(session[:cart_id])
        session[:cart_id] = nil
        
        puts "success --- #{result.transaction.id}"
        # response[:transaction_id] = result.transaction.id
        format.html { redirect_to order_path(@order), notice: 'Your order successfully placed.' }
        format.json { head :no_content }
      elsif result.transaction
        puts "Error Processiong Transaction"
        # response[:error] = result.transaction.processor_response_text
        # format.html { render :action => 'new', alert: result.transaction.processor_response_text } 
        format.html { redirect_to payments_new_path(order_id: @order.id), alert: result.transaction.processor_response_text }
        format.json { head :no_content }
      else
        puts result.errors
        # response[:error] = result.errors.inspect
        # format.html { render :action => 'new', alert: result.errors.map(&:message).join(",") } 
        format.html { redirect_to payments_new_path(order_id: @order.id), alert: result.errors.map(&:message).join(",") }
        format.json { head :no_content }
      end
    end
    # render :json => response
  end
end