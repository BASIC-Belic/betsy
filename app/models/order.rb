class Order < ApplicationRecord
  # belongs_to :user
  has_many :order_items

  VALID_MONTHS = (01..12).to_a

  attr_reader :valid_years

  validates_inclusion_of :credit_card_exp_month, :in => VALID_MONTHS, message: "Please enter a valid month.", on: :update

  validates :credit_card_exp_year, :in => @valid_years, on: :update

  validates :order_items, numericality: :greater_than_zero, on: :update

  def valid_years

    two_digit_date = Date.today.year % 1000
    @valid_years = (two_digit_date .. two_digit_date + 8).to_a
    return @valid_years
  end


  def greater_than_zero
    if self.field_name < 1
      self.errors.add(:field_name, "#{field_name} can't less than one")
    end
  end
end
