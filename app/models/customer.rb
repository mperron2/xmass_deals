class Customer < ApplicationRecord
  validates :postal_code, format: { with: /\A[A-Za-z]\d[A-Za-z] \d[A-Za-z]\d\z/, message: "must be in the format A1A 1A1" }, allow_blank: true
end
