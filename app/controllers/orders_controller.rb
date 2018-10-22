class OrdersController < ApplicationController

  def show
    current_order = Order.find_by(id: params[:id])
    # @order_items = @current_order.order_items

    @order_items = OrderItem.where(order_id: current_order.id)
    # @order_items = current_order.order_items

  end
end
