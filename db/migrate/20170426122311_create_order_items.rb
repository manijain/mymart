class CreateOrderItems < ActiveRecord::Migration
  def change
    create_table :order_items do |t|
      t.integer :item_quantity
      t.references :order
      t.references :product
      t.timestamps null: false
    end
  end
end
