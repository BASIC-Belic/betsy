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


  #
  # describe 'validations' do
  #
  #   before do
  #     @item_one = Item.new(
  #       name: 'test work'
  #       category:
  #       price:
  #       quantity_avaliable:
  #       user_id:
  #
  #     )
  #
  #     @item_two = Item.new(
  #       name: 'test work'
  #       category:
  #       price:
  #       quantity_avaliable:
  #       user_id:
  #
  #     )
  #   end
  #
  #   it 'is valid when title is present and unique' do
  #
  #     is_valid = @wok.valid?
  #     expect( is_valid ).must_equal true
  #
  #   end
  #
  #
  #
  # end

end
