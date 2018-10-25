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
    it "succeeds for an exisiting user / merchant" do

      get user_path(@linda)
      must_respond_with :success
    end

    it "succeeds for an exisiting user / not merchant" do

      get user_path(@june)
      must_respond_with :success
    end

    it "renders 404 not_found for a non exiting user" do

      get user_path(0)
      must_respond_with :not_found
    end
  end

  describe "shop" do
    it "succeeds for an exisiting user / merchant" do

      # get shop_path(@linda)
      # must_respond_with :success
    end

    it "succeeds for an exisiting user / not merchant" do

      # get shop_path(@june)
      # must_respond_with :success
    end

    it "redirects with flash error message for a non exiting user" do

      # expect(get shop_path(0)).must_redirect_to root_path
    end
  end


end
