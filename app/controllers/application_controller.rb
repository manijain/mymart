class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  # before_action :authenticate_customer!

  private
  
  def current_cart
    if customer_signed_in?
      if current_customer.cart.present? && session[:cart_id].present?
        user_cart = current_customer.cart
        cart = Cart.find_by_id(session[:cart_id])
        if cart.present? && cart.order_items.present? && (cart.id != user_cart.id)
          cart.order_items.each do |item|
            item.cart = user_cart
            item.save
          end
          # cart.destroy
          cart = user_cart
          return cart
        else
          cart = user_cart
          return cart
        end
      elsif current_customer.cart.present?
        cart = current_customer.cart
        return cart
      elsif session[:cart_id].present?
        cart = Cart.find(session[:cart_id])
        cart.update_attributes(customer_id: current_customer.id)
        return cart
      else
        cart = Cart.create(customer_id: current_customer.id)
        return cart
      end
    end

    Cart.find(session[:cart_id])
    rescue ActiveRecord::RecordNotFound
    cart = Cart.create
    session[:cart_id] = cart.id
    cart
  end

  def authorize_user
    unless current_admin_user.present?
      redirect_to root_path, alert: "You are not authorized for this request."
    end
  end
end
