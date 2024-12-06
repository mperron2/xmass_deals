class Product < ApplicationRecord
  validates :name, :price, :description, presence: true
  validates :description, length: { maximum: 500 }
  validates :name, length: { minimum: 3, maximum: 100 }
  validates :price, numericality: { greater_than_or_equal_to: 0 }
  belongs_to :category
  validates :category, presence: true
  has_many :order_items
  has_many :orders, through: :order_items
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
