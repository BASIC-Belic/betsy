class Order < ApplicationRecord
  # belongs_to :user
  has_many :order_items

  VALID_MONTHS = (01..12).to_a

  attr_reader :valid_years

  validates_inclusion_of :credit_card_exp_month, :in => VALID_MONTHS, message: "Please enter a valid month.", on: :update

  validates :credit_card_exp_year, :in => @valid_years, on: :update

  def valid_years

    two_digit_date = Date.today.year % 1000
    @valid_years = (two_digit_date .. two_digit_date + 8).to_a
    return @valid_years

  end
end
