class ShiftsController < ApplicationController
  def new
    @shift = Shift.new
    @shops = Shop.where(user_id: current_user.id)
    @shop = Shop.new
  end

  def index
  end

  def show
    @shift = Shift.find(params[:id])
    @workers = Worker.where(shift_id: @shift.id)
    @worker = Worker.new
    @staffs = Staff.where(user_id: current_user.id)
    @work_patterns = WorkPattern.where(user_id: current_user.id)
  end
  
  def create
    shift = Shift.new(shift_params)
    shift.user_id = current_user.id
    if shift.save
      flash[:notice] = "You have created shift successfully."
    end
    redirect_to shift_path(shift.id)
  end

  def edit
  end
  
  def calculate
    
  end

  def preview
  end
  
  private
  
  def shift_params
    params.require(:shift).permit(:shop_id, :year, :month)
  end
  
end
