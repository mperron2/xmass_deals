class Order < ApplicationRecord
  belongs_to :customer
  has_many :order_items

  def self.ransackable_attributes(auth_object = nil)
    [ "cost", "created_at", "customer_id", "id", "status", "updated_at" ]
  end
end
