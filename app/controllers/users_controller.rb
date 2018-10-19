class UsersController < ApplicationController

  before_action :find_user_products, only: :shop


  #PROFILE, PURCHASE HISTORY
  def show
    # head: not_found unless @user
    head: not_found unless @current_user
    # render 'layouts/invalid_page', status: :not_found
  end

  def shop
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

  #PUT IN MODEL?
  def find_user_products

    @user_products = User.find_by(@current_user).products
  end
end
