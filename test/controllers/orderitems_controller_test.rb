require "test_helper"
require "pry"

describe OrderItemsController do

  describe "create" do

    it "can create an order item with good data" do

      order_item_data = {

        order_item: {
          item_id: Item.first.id,
          quantity_per_item: 1

        }
      }

      order = Order.last

      new_order_item = order.order_items.new(
        order_item_data[:order_item]
        )

      new_order_item.must_be :valid?, "Data was invalid. Please come fix this test."

      expect {
        post item_order_items_path(Item.first.id),
        params: order_item_data
      }.must_change('OrderItem.count', +1)

      # FIX THIS
      # must_redirect_to order_path(order.id)
    end

    it "does not create a new order item with bad data" do

      order_item_data = {

        order_item: {
          quantity_per_item: 1,
          item_id: Item.last.id
        }
      }


     OrderItem.new(order_item_data[:order_item]).wont_be :valid?, "Data wasn't invalid. Please come fix this test."

      # binding.pry


      # Act
      expect {

        post item_order_items_path(Item.last.id),
        params: order_item_data

      }.wont_change('OrderItem.count')

      # Assert
      # must_respond_with :bad_request
    end


    ##it sets initial status to "pending"


  end

end
