class AddColumnStatusAndShippingToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :status, :boolean
    add_column :orders, :shipping, :float
  end
end
