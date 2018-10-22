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
    success = @item.destroy
    if success
      flash[:success] = "Item successfully deleted."
      redirect_to root_path
    else
      flash[:error] = "Item not deleted."
      redirect_back fallback_location: root_path
    end

  end

  # a name must be unique
  # NOTE: change redirect in line 42 to something appropriate after I figure out what that is with team
  def create
    filtered_params = item_params()
    @item = Item.new(filtered_params)
    save_success = @item.save
    if save_success
      flash[:success] = "Item #{@item.name} successfully saved."
      redirect_to items_path
    else
      flash.now[:error] =  "Item was not saved."
      render :new, status: :bad_request
    end
  end

  def show
    head :not_found unless @item
    @order = current_order
  end

  def update

    success_save = @item.update(item_params)

    if success_save
      flash[:success] = "Item #{@item.name} successfully updated."
      redirect_to items_path
    else
      flash.now[:error] =  "Error in updating product"
      render :edit, status: 400
    end

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
