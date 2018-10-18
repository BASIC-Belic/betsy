class AddOrderAndItemOrderitem < ActiveRecord::Migration[5.2]
  def change
    add_reference :orderitems, :order, foreign_key: true
    add_reference :orderitems, :item, foreign_key: true
  end
end
