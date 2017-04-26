class OrdersController < ApplicationController
  def create

    if params[:product_id].present?
      product = Product.find(params[:product_id])
      
      order = Order.where(customer_id: current_customer.id, status: "initiate").first

      if !order.present?
        order = Order.create(status: "initiate", customer_id: current_customer.id, total_price: product.price)
      end
      
      order_items = OrderItem.where(product_id: product.id, order_id: order.id).first
      
      respond_to do |format|
        if order_items.present?
          count = order_items.item_quantity
          order_items.update(item_quantity: count+1)
          total_price = count+1*(product.price)
          if order.update(total_price: total_price)
            format.js { }
          else
            format.html { render action: 'new' }
          end
        else
          order_item = order.order_items.build(product_id: product.id, order_id: order.id, item_quantity: 1)            
          if order_item.save
            format.js { }
          else
            format.html { render action: 'new' }
          end
        end
      end
    end
  end

  def destroy
  end

  def show
  end
end