class ApplicationController < ActionController::Base

  before_action :find_current_user
  before_action :find_all_merchants
  before_action :require_login, except: :index

  private

  def find_current_user
    @current_user |= User.find_by(id: session[:user_id])
  end

  #find all merchants
  def find_all_merchants
    @merchants = User.where(products: [])
  end

  def require_login
    unless @current_user
      flash[:failure] = "You must be logged in to do that."
      redirect_to root_path
    end
  end
end
