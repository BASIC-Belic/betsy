require "test_helper"

describe UsersController do
  # it "must be a real test" do
  #   flunk "Need real tests"
  # end

  before do
    @linda = users(:one)
    @john = users(:two)
    @june = users(:june)
  end

  describe "show" do
    it "succeeds for an exisiting user / merchant with items" do

      get user_path(@linda)
      must_respond_with :success
    end

    it "succeeds for an exisiting user / merchant without items" do

      get user_path(@june)
      must_respond_with :success
    end

    it "renders 404 not_found for a non exiting user" do

      get user_path(0)
      must_respond_with :not_found
    end
  end

  describe "shop" do
    it "succeeds for an exisiting user / merchant with items" do
      #
      # @current_user = @linda
      # get shop_path(@linda)
      # must_redirect_to shop_path

    end

    it "succeeds for an exisiting user / merchant without items" do

      # get shop_path(@june)
      # must_redirect_to shop_path
    end

    it "redirects with flash error message for a non exiting user" do

      get shop_path(0)
      must_redirect_to root_path
      assert_equal 'You need to sign up to create a shop.', flash[:error]
    end
  end

end
