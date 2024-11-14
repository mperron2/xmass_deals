class Product < ApplicationRecord
  validates :name, :price, presence: true
  validates :description, presence: true, length: { maximum: 500 }
  belongs_to :category
  has_many :order_items
  has_one_attached :image

  def self.search(query)
    if query.present?
      where("name LIKE ?", "%#{query}%")
    else
      all
    end
  end

  def self.ransackable_associations(auth_object = nil)
    [ "category" ]
  end

  def self.ransackable_attributes(auth_object = nil)
    [ "category_id", "id", "in_stock", "name", "price", "created_at", "updated_at" ]
  end
end
