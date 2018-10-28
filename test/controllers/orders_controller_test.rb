require "test_helper"

describe OrdersController do

  before do
    @pending = orders(:one)
    @pending.credit_card_exp_month = Date.today.month
    @pending.credit_card_exp_year = Date.today.year % 1000

    @empty = Order.new

    @paid = orders(:two)
    @paid.credit_card_exp_month = Date.today.month
    @paid.credit_card_exp_year = Date.today.year % 1000

    @shipped = orders(:three)
    @shipped.credit_card_exp_month = Date.today.month
    @shipped.credit_card_exp_year = Date.today.year % 1000
  end

end
