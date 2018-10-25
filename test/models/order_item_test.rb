require "test_helper"

describe OrderItem do
#   let(:order_item) { OrderItem.new }
#
#   it "must be valid" do
#     value(order_item).must_be :valid?
#   end
  before do

  end

  it 'returns the name of an item given the OrderItem id' do
    category = categories(:luggage)
    user = users(:june)
    new_order = Order.create()

    new_item = Item.create(name: "PotatoHead", price: 15, quantity_available: 15, category_id: category.id, user_id: user.id)

    new_orderitem = OrderItem.create(order_id: new_order.id, item_id: new_item.id, quantity_per_item: 1)

    new_orderitem_item_id = new_orderitem.item_id

    item_name = new_orderitem.find_item_name(new_orderitem_item_id)

    expect(item_name).must_equal "PotatoHead"
  end
end
