class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  # before_action :authenticate_customer!

  private
  
  def current_cart
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
