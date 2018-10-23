class OrdersController < ApplicationController

  before_action :define_order_user

  def show
    current_order = Order.find_by(id: params[:id])
    # @order_items = @current_order.order_items

    @order_items = OrderItem.where(order_id: current_order.id)
    # @order_items = current_order.order_items
  end

  #fill out order details
  def edit

    @order = Order.find_by(id: params[:id])
  end

  #submit order button
  def update

    @order.order_items.each do |order_item|
      order_item.decrement_quantity_available_of_item
    end

    successful = @order.update(parsed_data)

    if successful

      flash[:success] = "Order #{@order.id} for #{@order.name} has been successfully received. Look out for an email with order confirmation."
      redirect_to order_path(@order)
    else

      flash.now[:error] =  "Error in submitting order."
      render :edit, status: 400
    end
  end

  private

  def order_params
    return params.require(:user).permit(
      :name,
      :email,
      :mailing_address,
      :name_on_card,
      :credit_card_num,
      :credit_card_exp_year,
      :credit_card_exp_month,
      :cvv_num,
      :zipcode
    )
  end

  def parsed_order_data
    return { name: order_params[:name], email: order_params[:email], mailing_address: order_params[:mailing_address], name_on_card: order_params[:name_on_card], credit_card_num: order_params[:credit_card_num],  credit_card_exp_year: order_params[:credit_card_exp_year], credit_card_exp_month: order_params[:credit_card_exp_month], user: define_order_user, status: "paid"
    }
  end

  def define_order_user
    if @current_user
      User.find(@current_user)
    else
      #reserved guest
      User.find(id:0)
    end
  end
end
