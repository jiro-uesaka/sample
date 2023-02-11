class ShopsController < ApplicationController
  
  def index
    @shops = Shop.where(user_id: current_user.id)
    @shop = Shop.new
  end
  
  def create
    shop = Shop.new(shop_params)
    shop.user_id = current_user.id
    if shop.save
      flash[:notice] = "You have created shop successfully."
    end
    redirect_to request.referer
  end

  def edit
    @shop = Shop.find(params[:id])
  end
  
  def update
    shop = Shop.find(params[:id])
    if shop.update(shop_params)
      flash[:notice] = "You have updated shop successfully."
    end
    redirect_to shops_path
  end
  
  def destroy
    shop = Shop.find(params[:id])
    if shop.destroy
      flash[:notice] = "You have delete shop successfully."
    end
    redirect_to shops_path
  end
  
  private
  
  def shop_params
    params.require(:shop).permit(:name, :max_worker, :min_worker, :holiday)
  end
  
end
