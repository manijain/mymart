class CreateCustomerAddresses < ActiveRecord::Migration
  def change
    create_table :customer_addresses do |t|
      t.string :address1
      t.string :address2
      t.string :city
      t.string :district
      t.string :state
      t.string :country
      t.integer :pincode
      t.integer :contact_details
      t.references :order

      t.timestamps null: false
    end
  end
end
