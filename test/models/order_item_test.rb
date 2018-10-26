require "test_helper"

describe OrderItem do
  before do
    @orderitem1 = order_items(:orderitem1)
    @orderitem2 = order_items(:orderitem2)
    @orderitem3 = order_items(:orderitem3)
  end

  let(:order_item_missing_item) {
    OrderItem.create(item: nil,
      order: Order.first)
    }

    let(:order_item_missing_order) {
      OrderItem.create(  item: Item.first,
      order: nil)
      }

    let(:submit_full_order_item) {
      @orderitem2.submit_order_item
      item = @orderitem2.item
      item.decrement_quantity_available(@orderitem2.quantity_per_item)
      @orderitem2
    }

  describe 'relations' do
    #REVIEW: REPLACE
    it "has an item" do
      expect(@orderitem1).must_respond_to :item
        expect(@orderitem1.item).must_be_kind_of Item
    end

    it "has an order" do
      expect(@orderitem1).must_respond_to :order
        expect(@orderitem1.order).must_be_kind_of Order
    end
  end

  describe 'validations' do

    it "will create a valid orderitem" do
      value(@orderitem1).must_be :valid?
    end

    it 'wont create be a valid order_item if the item is missing' do

      starting_count = OrderItem.count
      invalid_order_item = order_item_missing_item
      ending_count = OrderItem.count

      expect(ending_count).must_equal starting_count

      expect(invalid_order_item.valid?).must_equal false
      expect(invalid_order_item.errors.messages).must_include :item, :item_id
    end

    it 'wont create be a valid order_item if the order is missing' do

      starting_count = OrderItem.count
      invalid_order_item = order_item_missing_order
      ending_count = OrderItem.count

      expect(ending_count).must_equal starting_count

      expect(invalid_order_item.valid?).must_equal false
      expect(invalid_order_item.errors.messages).must_include :order, :order_id
    end
  end

  describe 'submit_order_item' do

    it 'will change the status to paid if order_item is not nil' do

      starting_item_quantity = @orderitem2.item.quantity_available
      quant_to_be_subtracted = @orderitem2.quantity_per_item
      expected_final_quant = starting_item_quantity - quant_to_be_subtracted
      starting_status = @orderitem2.status

    submitted_order = submit_full_order_item

    ending_status = submitted_order.status
    ending_quant = submitted_order.item.quantity_available

    expect(ending_quant).must_equal expected_final_quant
    expect(starting_status).must_equal "pending"
    expect(ending_status).must_equal "paid"
    end

    it 'will not change status if order_items have no items' do

      empty_order = order_item_missing_item
      start_stat = empty_order.status

      empty_order.submit_order_item

      end_stat = empty_order.status

      expect(end_stat).must_equal end_stat
    end
  end
end
