class CreateProducts < ActiveRecord::Migration[7.2]
  def change
    create_table :products do |t|
      t.string :name
      t.integer :price
      t.integer :in_stock
      t.references :category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
