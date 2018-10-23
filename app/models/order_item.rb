class OrderItem < ApplicationRecord
  belongs_to :order
  validates :item_id, presence: true

  def decrement_quantity_available(num)
    self.quantity_available -= num
  end

end
