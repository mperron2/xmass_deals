class CreateCustomers < ActiveRecord::Migration[7.2]
  def change
    create_table :customers do |t|
      t.string :name
      t.string :email
      t.string :password
      t.string :street_address
      t.string :city
      t.string :country

      t.timestamps
    end
  end
end
