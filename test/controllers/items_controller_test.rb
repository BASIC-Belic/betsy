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

  describe "create" do

    it "create success" do

      item_data = {
        item:
        {
          user_id: User.first.id,
          name: "A BRAND NEW THING",
          category_id: Category.first.id,
          price: 100,
          quantity_available: 100
        }
      }

      test_item = Item.new(item_data[:item])
      test_item.must_be :valid?, "Test data was invalid. Please come fix this test."

      expect {

        post items_path, params: item_data

      }.must_change('Item.count', +1)

      must_redirect_to shop_path

      expect flash[:success].must_equal"Item successfully saved."
    end

    it 'does not create an item' do







    end
  end

  describe "edit" do
    it "responds with success for an existing item" do
      get edit_item_path(Item.first)

      must_respond_with :success
    end
  end


  describe "update" do
    it "should show success when showing an existing product" do

      item = Item.first

      get item_path(item.id)

      must_respond_with :success
    end

  end

  describe 'destroy' do


    it 'destroy an existing item' do
      item = Item.create(name: "SOOO Unique", category: Category.first, user: User.first, price: 10, quantity_available: 10)
      # testing the database change
      expect {
        delete item_path(item)
      }.must_change('Item.count', -1)
      # testing the flash message
      expect flash[:success].must_equal "Item successfully deleted."
      # testing the path
      must_redirect_to root_path
    end

    it 'will not destroy an item that is part of an OrderItem' do
      @item = items(:shoes)
      @order = orders(:one)
      @new_order_item = OrderItem.create(order_id: @order.id, item_id: @item.id)

      item_count = Item.count

      delete item_path(@item)
      # database not changed
      expect(Item.count).must_equal item_count
      # flash error appears
      flash[:error].must_equal "Item cannot be deleted. There is a pending order with this item"
      # redirect back
      must_redirect_to root_path
    end
  end
end
