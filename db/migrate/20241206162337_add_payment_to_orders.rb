class AddPaymentToOrders < ActiveRecord::Migration[7.2]
  def change
    add_column :orders, :payment, :integer
  end
end
