class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :item

  validates :quantity_per_item, presence: true, numericality: { only_integer: true, greater_than: 0 }


  def submit_order_item

    item = Item.find_by(id: self.item_id)

    item.decrement_quantity_available(self.quantity_per_item)
    #change order item status
    self.status = "paid"
    self.save
  end



end
