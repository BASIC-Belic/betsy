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
  end

  it 'returns the name of an item given an item id' do

# binding.pry
    item_name = @item.name
# binding.pry
    new_order_item = OrderItem.create(order_id: @order.id, item_id: @item.id)
# binding.pry
    find_item_name = new_order_item.find_item_name(new_order_item.item_id)
# binding.pry

    expect(find_item_name).must_equal item_name
  end
end
