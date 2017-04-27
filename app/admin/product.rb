ActiveAdmin.register Product do
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
permit_params :title, :description, :price, :quantity, :picture
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end

  config.filters = false

  # index do
  #   column :picture

  #   column :updated_at
  #   actions
  # end

  form do |f|
    f.inputs "Product" do
      f.input :title
      f.input :description
      f.input :price
      f.input :quantity
      f.input :picture, as: :file
    end
    f.actions
  end
end