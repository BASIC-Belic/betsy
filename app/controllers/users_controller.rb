class UsersController < ApplicationController

  before_action :find_current_user_items, only: :shop
  #remove shop from below filter once conenct user_login
  before_action :find_searched_user, only: [:show, :shop]

  #PROFILE
  def show
    head :not_found unless @user
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

  def find_searched_user
    @user = User.find_by(id: params[:id])
  end

  def find_current_user_items
    #ncomment and use this code once have user_login
    # @current_user_items = @current_user.find_items
    @current_user = User.find(19)
    @current_user_items = User.find(19).items
  end
end
