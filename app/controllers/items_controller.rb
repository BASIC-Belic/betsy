class ItemsController < ApplicationController
  before_action :find_item_category, only: [:show]
  before_action :find_searched_item, only: [:show, :edit, :update, :destroy]

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
  def create
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
  end

  def show
    head :not_found unless @item
  end

  def update
    @item.update(item_params)
    redirect_to items_path
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
    find_searched_item
    @item_category = Category.find(@item.category_id).category_type
  end
end
