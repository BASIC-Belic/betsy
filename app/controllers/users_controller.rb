class UsersController < ApplicationController
  #remove shop from below filter once conenct user_login
  before_action :find_searched_user, only: [:show]
  before_action :find_current_user_items, only: [:shop]

  #PROFILE
  def show
    head :not_found unless @user
    # render 'layouts/invalid_page', status: :not_found
  end

  def shop
    redirect_to root_path unless @current_user
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
end
