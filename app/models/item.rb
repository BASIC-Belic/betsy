class Item < ApplicationRecord
  belongs_to :user
  has_many :order_items
  has_many :reviews
  belongs_to :category

  VALID_CATEGORIES = ["accessories", "books", "clothing", "seasonal", "luggage", "shoes", "tech", "miscellaneous"]

  validates :name, presence: true, uniqueness: {
    scope: [:user, :category], message: "User: has already added this item in this category. Please change item inventory."
  }

  # guest login set to 0
  def is_authenticated_user?
    session[:user_id] != 0 ? true: false
  end

  def user_created_product?
    if session[:user_id] == @item.user_id
      can_change = true
    else
      can_change == false
    end
    return can_change
  end

  def item_subtotal(price,qty)
    item_subtotal = price * qty
    return item_subtotal
  end

end
