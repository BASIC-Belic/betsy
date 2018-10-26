require "test_helper"

describe OrderItem do
  # let(:order_item) { OrderItem.new }
  #
  # it "must be valid" do
  #   value(order_item).must_be :valid?
  # end
  before do
    @item = items(:shoes)
    @order = orders(:one)
    @new_order_item = OrderItem.create(order_id: @order.id, item_id: @item.id)
  end

  it 'returns the name of an item given an item id' do
    item_name = @item.name
    find_item_name = @new_order_item.find_item_name(@new_order_item.item_id)

    expect(find_item_name).must_equal item_name
  end

  it 'returns the order instance linked to an order_item' do
    find_order = @new_order_item.find_order(@new_order_item.order_id)

    expect(find_order).must_equal @order
  end
end
