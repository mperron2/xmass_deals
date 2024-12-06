ActiveAdmin.register Customer do
  permit_params :name, :email, :street_address, :city, :province, :postal_code
end
