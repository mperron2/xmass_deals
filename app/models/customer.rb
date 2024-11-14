class Customer < ApplicationRecord
  has_many :orders
  validates :name, :email, :pasword, :street_address, :city, presence: true
  validates :postal_code, format: { with: /\A[A-Za-z]\d[A-Za-z] \d[A-Za-z]\d\z/, message: "must be in the format A1A 1A1" }, allow_blank: false

  def self.ransackable_associations(auth_object = nil)
    [ "orders" ]
  end

  def self.ransackable_attributes(auth_object = nil)
    [ "id", "email", "name", "password", "postal_code", "street_address", "city", "created_at", "updated_at" ]
  end
end
