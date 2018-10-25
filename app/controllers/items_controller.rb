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

    in_order = OrderItem.find_by(item_id: @item.id)


    if in_order
      flash[:error] = "Item cannot be deleted. There is a pending order with this item"
      # redirect_back (fallback_location: root_path)
      redirect_back(fallback_location: root_path)
    else
      success = @item.destroy
      flash[:success] = "Item successfully deleted."
      redirect_back(fallback_location: root_path)
    end
    
  end


  # a name must be unique

  def create
    category = Category.find_by(category_type: item_params[:category_type])

    @item = Item.new(get_filtered_params(item_params, category))

    save_success = @item.save
    if save_success
      flash[:success] = "Item #{@item.name} successfully saved."
      redirect_to shop_path
    else
      flash.now[:error] =  "Item was not saved."
      render :new, status: :bad_request
    end

  end

  def show
    head :not_found unless @item
    @order = Order.find_by(id: session[:order_id])
  end

  def update

    category = Category.find_by(category_type: item_params[:category_type])

    success_save = @item.update(get_filtered_params(item_params, category))

    if success_save
      flash[:success] = "Item #{@item.name} successfully updated."
      redirect_to shop_path
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

  def get_filtered_params(filtered_params, category)
    return { name: filtered_params[:name], price: filtered_params[:price], quantity_available: filtered_params[:quantity_available], description: filtered_params[:description], image: filtered_params[:image], active: filtered_params[:active], category: category, user_id: @current_user.id }
  end

  def find_item_category
    @item_category = Category.find(@item.category_id).category_type
  end

end
