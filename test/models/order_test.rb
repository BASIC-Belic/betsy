require "test_helper"

describe Order do
  before do
    @pending = orders(:one)
    @pending.credit_card_exp_month = Date.today.month
    @pending.credit_card_exp_year = Date.today.year


    @paid = orders(:two)
    @paid.credit_card_exp_month = Date.today.month
    @paid.credit_card_exp_year = Date.today.year

    @shipped = orders(:three)
    @shipped.credit_card_exp_month = Date.today.month
    @shipped.credit_card_exp_year = Date.today.year
  end

  describe 'relations' do
    it "has a list of order_items" do
      expect(@pending).must_respond_to :order_items
      @pending.order_items.each do |order_item|
        expect(order_item).must_be_kind_of OrderItem
      end
    end
  end

  it "must be valid" do

  end
end
