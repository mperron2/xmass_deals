class ChangeIntegerToDoubleInOrdersAndOrderItems < ActiveRecord::Migration[6.1]
  def up
    change_column :order_items, :price, :decimal, precision: 10, scale: 2
    change_column :orders, :cost, :decimal, precision: 10, scale: 2
  end

  def down
    change_column :order_items, :price, :integer
    change_column :orders, :cost, :integer
  end
end
