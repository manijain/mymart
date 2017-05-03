class AddColumnShippingToCart < ActiveRecord::Migration
  def change
    add_column :carts, :shipping, :float
  end
end
