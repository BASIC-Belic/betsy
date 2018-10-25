class UsersController < ApplicationController
  #remove shop from below filter once conenct user_login
  before_action :find_searched_user, only: [:show]
  before_action :find_current_user_items, only: [:shop]
  before_action :find_current_user_unfulfilled_items, only: [:shop]

  #user profile / merchant page that is visible to all
  def show
    head :not_found unless @user
    # render 'layouts/invalid_page', status: :not_found
  end

  #merchant view that is visible to just merchants
  def shop
    unless @current_user
      flash[:error] = "You need to sign up to create a shop."
      redirect_to root_path
    end
  end

  private

  #strong params
  def user_params
    return params.require(:user).permit(
      :name,
      :nickname,
      :email,
      :image_url,
      :uid,
      :provider
    )
  end

  def find_searched_user
    @user = User.find_by(id: params[:id])
  end

  #instance method to find items this user sells
  def find_current_user_items
    if @current_user
      @current_user_items = @current_user.items
    end
  end

  def find_current_user_unfulfilled_items

    # @current_merchant_unfulfilled_order_items = @current_user_items.map do |item|
    #   OrderItem.where(item_id: item.id) && OrderItem.where(status: "ordered")
    # end
    # @current_merchant_unfulfilled_order_items.flatten!
  end
end
