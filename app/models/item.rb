class Item < ApplicationRecord
  belongs_to :user
  has_many :orderitems
  has_many :reviews
  belongs_to :category
end
