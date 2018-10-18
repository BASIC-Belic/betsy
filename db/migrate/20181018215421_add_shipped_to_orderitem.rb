class AddShippedToOrderitem < ActiveRecord::Migration[5.2]
  def change
    add_column :orderitems, :shipped, :boolean, default:false
  end
end
