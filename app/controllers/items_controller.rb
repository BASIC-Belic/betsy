class ItemsController < ApplicationController


  def index
    @items = Item.all
  end

  def edit
    @item = Item.find_by(id: params[:id])
  end

  def new
    @item = Item.new
  end

  def destroy
    item = Item.find_by(id: params[:id])
    item.destroy
    redirect_to root_path
  end

  # a name must be unique
  def create
    not_unique_name = Item.find_by(name: params[:name])
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
      item_id = params[:id]
      @item = Item.find_by(id: item_id)
      if @item.nil?
        head :not_found
      end
    end

    def update
      @item = Item.find(params[:id])
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
  end
