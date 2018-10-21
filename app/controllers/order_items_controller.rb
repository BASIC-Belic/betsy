class OrderItemsController < ApplicationController

  def create

    @order = current_order
    @item = Item.find_by(id: params[:item_id])


    @order_item = @order.order_items.new(item_id: @item.id, quantity_per_item: params[:quantity_per_item])

    if @order_item.save
      session[:order_id] = @order.id
      redirect_to order_path(@order.id)
    end

  end



  def update
    @order = current_order
    @order_item = @order.order_items.find(params[:id])

    @order_item.update_attributes(quantity_per_item: params[:quantity_per_item])
    @order_items = @order.order_items

    redirect_to order_path(@order)
  end


  def destroy
    @order = current_order
    @order_item = @order.order_items.find(params[:id])
    @order_item.destroy
    @order_items = @order.order_items

    redirect_to order_path(@order)
  end


  private
  def order_item_params
    params.require(:order_item).permit(:shipped, :order_id, :item_id, :quantity_per_item)
  end

end
