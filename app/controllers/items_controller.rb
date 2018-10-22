class ItemsController < ApplicationController
  before_action :find_searched_item, only: [:show, :edit, :update, :destroy, :find_item_category,]
  before_action :find_item_category, only: [:show]

  def index
    @items = Item.all
  end

  def edit
  end

  def new

    @item = Item.new
  end

  def destroy
    @item.destroy
    redirect_to root_path
  end

  # a name must be unique
  # NOTE: change redirect in line 42 to something appropriate after I figure out what that is with team
  def create
    if is_authenticated_user?
      not_unique_name = Item.find_by(id: params[:id])
      if not_unique_name
        flash[:error]= "A Problem Occured: item with this name already exists"
      else
        filtered_params = item_params()
        @item = Item.new(filtered_params)
        save_success = @item.save
        if save_success
          redirect_to items_path
        else
          flash.now[:error] =  "Invalid item entry"
          render :new, status: :bad_request
        end
      end
    else
      flash.now[:error] =  "You must be a merchant to create a product"
        redirect_to root_path
    end
  end

  def show
    head :not_found unless @item
  end

   def update
  #   if is_authenticated_user? && user_created_product?
      @item.update(item_params)
      redirect_to items_path
    else
    #   flash.now[:error] =  "You must be a merchant to update"
    # end
    end

    private

    def item_params
      return params.require(:item).permit(
        :name,
        :category,
        :price,
        :quantity_available,
        :description,
        :image,
        :active

      )
    end

    def find_searched_item
      @item = Item.find_by(id: params[:id])
    end

    def find_item_category
      @item_category = Category.find(@item.category_id).category_type
    end
  end
