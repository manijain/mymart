class AddColumnIsAdminToCustomer < ActiveRecord::Migration
  def change
    add_column :customers, :is_admin, :boolean, default: false
  end
end
