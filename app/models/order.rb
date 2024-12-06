class Order < ApplicationRecord
  belongs_to :customer
  has_many :order_items
  has_many :products, through: :order_items
  validates :status, presence: true
  validates :payment, presence: true, numericality: { only_integer: true }
  validates :cost, presence: true, numericality: { greater_than_or_equal_to: 0 }

  def self.ransackable_attributes(auth_object = nil)
    [ "cost", "created_at", "customer_id", "id", "status", "updated_at" ]
  end
end
