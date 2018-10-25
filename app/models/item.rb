class Item < ApplicationRecord
  belongs_to :user
  has_many :order_items
  has_many :reviews
  belongs_to :category

  VALID_CATEGORIES = ["accessories", "books", "clothing", "seasonal", "luggage", "shoes", "tech", "miscellaneous"]

  validates :name, presence: true, uniqueness: {
    scope: [:user, :category], message: "User: has already added this item in this category. Please change item inventory."
  }

  validates :price, presence: true
  validates :quantity_available,   presence: true

  def decrement_quantity_available(num)
    # if self.quantity_available.nil?
    #   #error message here, user this self.name item is sold out?
    # end

    self.quantity_available -= num
    self.s ave
  end

  # guest login set to 0
  def is_authenticated_user?
    session[:user_id] != 0 ? true: false
  end

  def user_created_product?
    if session[:user_id] == @item.user_id
      user_created = true
    else
      user_created = false
    end
    return user_created
  end


  def return_quantity_selection

    iterations = self.quantity_available

    quantity_options = []

    iterations.times do |number|
      quantity_options << number + 1
    end

    return quantity_options
  end

  def item_subtotal(price,qty)
    item_subtotal = price * qty

    return item_subtotal
  end

  def total_reviews
    reviews = []
    reviews << self.reviews
    return reviews
  end

end
