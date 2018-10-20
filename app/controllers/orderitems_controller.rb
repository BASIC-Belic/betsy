class OrderitemsController < ApplicationController

  def create

    @order_item = @order.order_items.new(order_item_params)
    @order.save

  end


  def show
    #show page for shopping cart that hasn't been submitted
  end





  def update
    @order_item = @order.order_items.find(params[:id])
    @order_item.update_attributes(order_item_params)
    @order_items = @order.order_items
  end


  def destroy
    @order_item = @order.order_items.find(params[:id])
    @order_item.destroy
    @order_items = @order.order_items
  end


  private
  def order_item_params
    params.require(:order_item).permit(:shipped, :order_id, :item_id, :quantity_per_item)
  end

end
