require "test_helper"

describe ItemsController do
  describe 'index' do
    it "succeeds when there are items" do
      get items_path
      must_respond_with :success
    end
  end

  describe "show" do
    it "responds with success for showing an existing product" do

      test_item = items.first
      id = test_item.id

      get item_path(id)

      must_respond_with :success
    end

  end

  describe "new" do
    it "successful new page" do

      get new_item_path

      must_respond_with :success

    end
  end

  # describe "create" do
  #
  #   it "creates new item when logged in and given valid data" do
  #
  #     @category_one = Category.first
  #     merchant = users(:one)
  #     item_details = {
  #       name: 'test',
  #       category: @category_one,
  #       price: 30,
  #       quantity_available: 2,
  #       user: merchant
  #     }
  #
  #     OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new(mock_auth_hash(users))
  #
  #     get auth_callback_path(:github)
  #
  #
  #     test_item = Item.new(item_details)
  #
  #     must_respond_with :redirect
  #     expect {
  #       post item_path, params: item_details }.must_change 'Item.count', 1
  #
  #       expect(Product.last.name).must_equal item_details[:item][:name]
  #     end
  #   end

    describe "edit" do
      it "responds with success for an existing item" do
        get edit_item_path(Item.first)

        must_respond_with :success
      end

      # it "responds with not_found for a product that doesn't exist" do
      #   item = Item.first.destroy
      #
      #   get edit_item_path(item)
      #
      #   must_respond_with :not_found
      # end
    end
    #
    describe "update" do
      it "should show success when showing an existing product" do

        item = Item.first

        get item_path(item.id)

        must_respond_with :success
      end

      # it "should return error message if product doesn't exist" do
      #
      #   item = Item.first
      #   id = item.id
      #   item.destroy
      #
      #   get item_path(id)
      #
      #   must_respond_with :not_fou
      # end
    end
    #
    describe "destroy" do
      it "can destroy an existing item" do
        item = Item.first

        expect {
          delete item_path(item)
        }.must_change('Item.count', -1)
        flash[:success].must_equal "Item successfully deleted."
      end


      it 'will not destroy an item that is part of an OrderItem' do
        @item = items(:shoes)
        @order = orders(:one)
        @new_order_item = OrderItem.create(order_id: @order.id, item_id: @item.id)

        item_count = Item.count

        delete item_path(@item)

        expect(Item.count).must_equal item_count
        flash[:error].must_equal "Item cannot be deleted. There is a pending order with this item"
      end
    end

  end
