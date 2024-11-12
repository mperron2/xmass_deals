class CreateOrders < ActiveRecord::Migration[7.2]
  def change
    create_table :orders do |t|
      t.integer :cost
      t.datetime :created_at
      t.string :status
      t.references :customer, null: false, foreign_key: true

      t.timestamps
    end
  end
end
