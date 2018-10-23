class StatusController < ApplicationController
  def show
    @order = Order.find_by(id: params[:id])
    orderitems = OrderItem.where(order_id: params[:id])
    ids_items_purchased = orderitems.map do |item|
      item.item_id
    end

    @items_purchased = []
    ids_items_purchased.each do |id|
      item = Item.find_by(id: id)
      @items_purchased << item
    end

  end
end
