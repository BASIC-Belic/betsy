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

    category = Category.find_by(category_type: filtered_params[:category_type])

    @item = Item.new(name: filtered_params[:name], price: filtered_params[:price], quantity_available: filtered_params[:quantity_available], description: filtered_params[:description], image: filtered_params[:image], active: filtered_params[:active], category: category, user_id: @current_user.id)

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

    filtered_params = item_params()

    category = Category.find_by(category_type: filtered_params[:category_type])

    success_save = @item.update(name: filtered_params[:name], price: filtered_params[:price], quantity_available: filtered_params[:quantity_available], description: filtered_params[:description], image: filtered_params[:image], active: filtered_params[:active], category: category, user_id: @current_user.id)

    if success_save
      flash[:success] = "Item #{@item.name} successfully updated."
      redirect_to item_path(@item.id)
    else
      flash.now[:error] =  "Error in updating product"
      render :edit, status: 400
    end

  end

  private

  def item_params
    return params.require(:item).permit(
      :name,
      :category_type,
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
