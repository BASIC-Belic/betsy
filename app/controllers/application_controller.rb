class ApplicationController < ActionController::Base


  before_action :find_current_user
  before_action :find_all_merchants

  private

  def find_current_user
    @current_user |= User.find_by(id: session[:user_id])
  end

  #find all merchants
  def find_all_merchants
    @merchants = User.where(products: [])
  end

end
