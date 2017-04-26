class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.string :status
      t.float :total_price
      t.references :customer

      t.timestamps null: false
    end
  end
end
