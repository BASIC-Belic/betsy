class OrderItem < ApplicationRecord
  belongs_to :order
  validates :item_id, presence: true

  def decrement_quantity_available_of_item

    item = Item.find_by(id: self.item_id)
    item.decrement_quantity_available(self.quantity_per_item)
  end

end
