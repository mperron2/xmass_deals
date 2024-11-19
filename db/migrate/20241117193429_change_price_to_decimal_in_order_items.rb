class ChangePriceToDecimalInOrderItems < ActiveRecord::Migration[7.2]
  def change
    change_column :products, :price, :decimal, precision: 10, scale: 2
  end
end
