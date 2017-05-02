class AddCoulmnCustomerIdToCustomerAddress < ActiveRecord::Migration
  def change
    add_column :customer_addresses, :customer_id, :integer
  end
end
