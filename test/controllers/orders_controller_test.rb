require "test_helper"

describe OrdersController do

  before do
    @pending = orders(:one)
    @pending.credit_card_exp_month = Date.today.month
    @pending.credit_card_exp_year = Date.today.year % 1000

    @empty = Order.new

    @pending = orders(:two)

    @shipped = orders(:three)
    @shipped.credit_card_exp_month = Date.today.month
    @shipped.credit_card_exp_year = Date.today.year % 1000

    @linda = users(:one)
  end

  describe 'show' do
    it "succeeds for an exisiting order" do
      get order_path(@pending)
      must_respond_with :success
    end
  end

  # def edit
  #
  #   @order = Order.find_by(id: params[:id])
  # end

  let (:logged_in_linda) {
    OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new(mock_auth_hash(@linda))

    get auth_callback_path(:github)
  }

  describe 'edit' do

    it "will allow a guest user to access/edit their own order" do
      current_order = Order.create
      # controller.session[:order_id] = new_order.id
      # session[:order_id] = new_order.id
      # session.update
      # binding.pry
      # Session.new(order_id: 1)

      get order_path(current_order)

      expect(current_order.order_items.empty?).must_equal true
      must_respond_with :success
    end

    it "will allow a logged in user to access/edit their own order" do
      logged_in_linda

      get order_path(session[:order_id])
      must_respond_with :success
    end
  end

  describe 'update' do
    it 'will redirect to status_path and save valid order info' do
      skip
      # updated_year = Date.today.year % 1000
      # updated_month = Date.today.month
      #
      #   order_data = {
      #     order:
      #       credit_card_exp_year: Date.today.year % 1000,
      #       credit_card_exp_month: Date.today.month
      #     }
      #   }
      #
      #   expect {
      #     put order_path(@pending.id), params: order_data
      #
      #   }.wont_change 'Order.count'

        # assert_equal updated_year, @pending.credit_card_exp_year
        # assert_equal updated_month, @pending.credit_card_exp_month
    end

    it 'will render the page again status for bad request' do
      skip
    end

    it 'will change the status of the order to paid' do
      skip
    end

    it 'will change the status of all orderitems to paid' do
      skip
    end

    it 'will decrement the items according to quantity_per_item ' do
      skip
    end

    it 'will clear out session[:order_id]' do
      skip
    end
  end
end
