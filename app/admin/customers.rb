ActiveAdmin.register Customer do
  permit_params :name, :email, :password, :street_address, :city, :postal_code
end
