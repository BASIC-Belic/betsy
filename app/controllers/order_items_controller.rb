class OrderItemsController < ApplicationController

  def create

    @order = current_order
    @item = Item.find_by(id: params[:item_id])


    @order_item = @order.order_items.new(
      item_id: @item.id,
      quantity_per_item: params[:quantity_per_item]
    )

    if @order_item.save
      session[:order_id] = @order.id
      redirect_to order_path(@order.id)
    end

  end


  def update
    @order = current_order
    @order_item = @order.order_items.find_by(id: params[:id])

    @order_item.update(quantity_per_item: params[:quantity_per_item])


    redirect_to order_path(@order)
  end


  def increment_quantity
    @order = current_order
    @order_item = @order.order_items.find_by(item_id: params[:item_id])

    additional_quantity = params[:quantity_per_item].to_i

    new_quantity = @order_item.quantity_per_item + additional_quantity

    @order_item.update(quantity_per_item: new_quantity)

    redirect_to order_path(@order)
  end


  def destroy
    @order = current_order
    @order_item = @order.order_items.find(params[:id])
    @order_item.destroy

    redirect_to order_path(@order)
  end


  private
  def order_item_params
    params.require(:order_item).permit(:shipped, :order_id, :item_id, :quantity_per_item)
  end

end
