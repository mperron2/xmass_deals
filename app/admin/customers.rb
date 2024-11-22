ActiveAdmin.register Customer do
  permit_params :name, :street_address, :city, :postal_code
end
