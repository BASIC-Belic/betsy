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

  describe 'relations' do
    #REVIEW: REPLACE
    # it "has a list of items" do
    #   expect(@linda).must_respond_to :items
    #   @linda.items.each do |item|
    #     expect(item).must_be_kind_of Item
    #   end
    # end
    #
    # it "has a list of reviews" do
    #   expect(@linda).must_respond_to :reviews
    #   #NEED TO GIVE A YAML REVIEW
    #   @linda.must_respond_to :reviews
    #   @linda.reviews.each do |review|
    #     expect(review).must_be_kind_of Review
    #   end
    # end
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
end
