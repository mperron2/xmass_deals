class RemoveCountryFromCustomers < ActiveRecord::Migration[7.2]
  def change
    remove_column :customers, :country, :string
  end
end
