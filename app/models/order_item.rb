class OrderItem < ApplicationRecord
  belongs_to :order
  validates :item_id, presence: true

  def self.update_quantity

  end

end
