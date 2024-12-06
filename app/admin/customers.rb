ActiveAdmin.register Customer do
  permit_params :name, :email, :street_address, :city, :province, :postal_code
  index do
    selectable_column
    id_column
    column :name
    column :email
    column :street_address
    column :city
    column :province
    column :postal_code
    actions
  end

  form do |f|
    f.inputs "Customer Details" do
      f.input :name
      f.input :email
      f.input :street_address
      f.input :city
      f.input :province
      f.input :postal_code
    end
    f.actions
  end
end
