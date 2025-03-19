class Product < ApplicationRecord
  belongs_to :shop
  
  validates :title, presence: true
  validates :description, presence: true
  validates :price, presence: true, numericality: { greater_than: 0 }
  validates :inventory_count, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
end
