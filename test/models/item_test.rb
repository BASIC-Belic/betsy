require "test_helper"

describe Item do


  #relation tests: an order has many items, a category has many items

  describe 'relations' do

    it 'an item belongs to a category' do

      category = Item.first.category

      expect category.must_be_kind_of Category
    end

    it 'an item belongs to a user' do

      user = Item.first.user
      expect user.must_be_kind_of User
    end

  end

  describe 'validations' do

    before do
      @user_one = Item.first.user
      @category_one = Category.first
      @category_two = Category.first

      # no name
      @nameless_item = Item.new(
        name: nil,
        category: @category_one,
        price: 40,
        quantity_available: 2,
        user: @user_one

      )
      # no price
      @priceless_item = Item.new(
        name: 'no price',
        category: @category_one,
        price: nil,
        quantity_available: 3,
        user: @user_one

      )
      # no quantitiy
      @quantityless_item = Item.new(
        name: 'no quantitiy',
        category: @category_one,
        price: 30,
        quantity_available: nil,
        user: @user_one
      )
      # same name, same qty, same category (duplicate)

      @thing_one = Item.new(
        name: 'twin',
        category: @category_one,
        price: 30,
        quantity_available: 2,
        user: @user_one
      )

      @thing_two = Item.new(
        name: 'twin',
        category: @category_one,
        price: 30,
        quantity_available: 2,
        user: @user_one
      )

      # same everything diff category is valid

      @same_name_diff_cat = Item.new(
        name: 'cat',
        category: Category.first,
        price: 30,
        quantity_available: 3,
        user: @user_one
      )

      @diff_cat = Item.new(
        name: 'cat',
        category: Category.first,
        price: 30,
        quantity_available: 3,
        user: @user_one
      )

    end

    it 'is valid when title, category, and price is present' do
      @valid_item = Item.first
      is_valid = @valid_item.valid?
      expect( is_valid ).must_equal true

    end

    it 'is not valid without a name' do
      is_valid = @nameless_item.valid?
      expect( is_valid ).must_equal false

    end

    it 'is not valid without a price' do
      is_valid = @priceless_item.valid?
      expect( is_valid ).must_equal false
    end

    it 'is not valid without a quantitiy' do
      is_valid = @quantityless_item.valid?
      expect( is_valid ).must_equal false
    end

    # it 'is not valid with same name, quantity, and price' do
    #   is_valid = @thing_two.valid?
    #   expect( is_valid ).must_equal false
    # end

    it 'is valid with same name, diff category' do
      is_valid = @same_name_diff_cat.valid?
      expect ( is_valid ).must_equal true

    end

    describe 'custom methods' do
      before do
        @item = items(:shoes)
        @order = orders(:one)
        @new_order_item = OrderItem.create(order_id: @order.id, item_id: @item.id, quantity_per_item: 2)
      end

      it 'returns an items subtotal' do
        quantity_purchased = @new_order_item.quantity_per_item
        price_of_item = @item.price
        subtotal = @item.item_subtotal(price_of_item, quantity_purchased)

        expect(subtotal).must_equal @item.price * 2
      end
    end

  end

  # describe 'custom methods' do
  #
  #   it 'decreases an item quantity by 1' do
  #     test_item = Item.first
  #     start_quantity = test_item.quantity_available
  #     end_quantity = start_quantity.decrement_quantity_available(1)
  #     decremented_quantity = start_quantity - 1
  #
  #     expect ( end_quantity ).must_equal decremented_quantity
  #
  #   end
  #
  # end


end
