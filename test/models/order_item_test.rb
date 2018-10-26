require "test_helper"

describe OrderItem do

  #   let(:order_item) { OrderItem.new }
  #
  #   it "must be valid" do
  #     value(order_item).must_be :valid?
  #   end
  # before do

  # end

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
  # end
end
