class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :item
  validates :item_id, presence: true
  validates :order_id, presence: true

  def submit_order_item

    item = Item.find_by(id: self.item_id)

    item.decrement_quantity_available(self.quantity_per_item)
    #change order item status
    self.status = "paid"
    self.save
  end



end
