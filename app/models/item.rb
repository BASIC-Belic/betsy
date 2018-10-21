class Item < ApplicationRecord
  belongs_to :user
  has_many :order_items
  has_many :reviews
  belongs_to :category
end
