class CreateOrderItems < ActiveRecord::Migration
  def change
    create_table :order_items do |t|
      t.integer :item_quantity, default: 1
      t.references :cart
      t.references :product
      t.references :order
      t.timestamps null: false
    end
  end
end
