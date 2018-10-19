class UsersController < ApplicationController

  # before_action :find_user, only: :show
  
  before_action :find_user_products, only: :shop
  before_action :find_user_orders, only: :orders

  #UNECESSARY????
  def index
    @users = User.all
  end

  #PROFILE, PURCHASE HISTORY
  def show
    # head: not_found unless @user
    head: not_found unless @current_user
    # render 'layouts/invalid_page', status: :not_found
  end

  def shop
    if !@user_products
      #guest user
      #render 'layouts/forbidden', status: 400?
    end
    #in view: if @user_products = [], secondary view: become a merchant!
    #else, just show products and add products button
    #product show should have conditional for editing products
  end

  def orders
    if !@user_orders
      #guest user
      #render 'layouts/forbidden', status: 400?
    end
    #in view: if @user_products = [], secondary view: become a merchant!
    #else, just show products and add products button
    #product show should have conditional for editing products
  end

  # def new
  #   @user = User.new()
  # end
  #
  # def create
  #   filtered_user_params = user_params()
  #   @user = User.new(filtered_user_params)
  #
  #   if @user.save
  #     session[:user_id] = @user.id
  #     flash[:success] = "User #{@user.username} has successfully signed up and logged in!"
  #     redirect_to root_path
  #   else
  #     flash.now[:failure] = "Error: user could not be saved."
  #     render :new, status: 400
  #   end
  # end

  # def destroy
  #   if @user.destroy
  #     flash[:success] = "User #{@user.id} has been deleted"
  #     redirect_to root_path
  #   else
  #     flash[:failure] = "User #{@user.id} could not be deleted. Sorry about it.¯\\_(ツ)_/¯"
  #     redirect_back fallback_location: root_path
  #   end
  # end

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

  # def find_user
  #   @user = User.find_by(id: params[:id])
  # end

  #PUT IN MODEL?
  def find_user_products
    if @current_user
      @user_products = User.find_by(id: session[:user_id]).products
    elsif session[:guest_user_id]
      @user_products = nil
    end
  end

  #PUT IN MODEL?
  def find_user_orders
    if @current_user
      @user_orders = User.find_by(id: session[:user_id]).orders
    elsif session[:guest_user_id]
      @user_orders = nil
    end
  end

end
