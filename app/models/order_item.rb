class OrderItem < ApplicationRecord
  belongs_to :order
  validates :item_id, presence: true



  def return_quantity_selection

    iterations = self.quantity_available

    quantity_options = []

    iterations.times do |number|
      quantity_options << number + 1
    end

    return quantity_options
  end
  
end
