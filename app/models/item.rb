class Item < ApplicationRecord
  belongs_to :user
  has_many :order_items
  has_many :reviews
  belongs_to :category

  # guest login set to 0
  def is_authenticated_user?
    session[:user_id] != 0 ? authentic_user = true : authentic_user = false
    return authentic_user
  end

  def user_created_product?
    if session[:user_id] == @item.user_id
      can_change = true
    else
      can_change == false
    end
    return can_change
  end

end
