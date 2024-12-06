class Order < ApplicationRecord
  belongs_to :customer
  has_many :order_items
  has_many :products, through: :order_items
  validates :status, :payment, :cost, presence: true
  validates :payment, numericality: { only_integer: true }
  validates :cost, numericality: { greater_than_or_equal_to: 0 }

  def self.ransackable_attributes(auth_object = nil)
    [ "cost", "created_at", "customer_id", "id", "status", "updated_at" ]
  end

  def self.ransackable_associations(auth_object = nil)
    [ "customer", "order_items", "products" ]
  end
end
