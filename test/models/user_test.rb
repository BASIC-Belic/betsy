require "test_helper"

describe User do

  before do
    @linda = users(:one)
    @john = users(:two)
    @june = users(:june)
  end

  describe 'relations' do
    it "has a list of items" do
      @linda.must_respond_to :items
      @linda.items.each do |item|
        item.must_be_kind_of Item
      end
    end

    it "has a list of reviews" do
      @linda.must_respond_to :reviews
      #NEED TO GIVE A YAML REVIEW
      @linda.must_respond_to :reviews
      # @linda.reviews.each do |review|
      #   review.must_be_kind_of Review
      # end
    end
  end



  describe 'validations' do
    it 'will create a valid user' do
      expect(@linda.valid?).must_equal true
    end
    it 'will not create a user with '
  end


  describe 'is_amerchant?(given_ids)' do
  end


  #Merchant / Signed in User
  # Username must be present
  # Username must be unique
  # Email Address must be present
  # Email Address must be unique


end
