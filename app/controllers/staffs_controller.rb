class StaffsController < ApplicationController
  def index
    @staffs = Staff.where(user_id: current_user.id)
    @staff = Staff.new
  end
  
  def create
    staff = Staff.new(staff_params)
    staff.user_id = current_user.id
    if staff.save
      flash[:notice] = "You have created staff successfully."
    end
    redirect_to request.referer
  end

  def edit
    @staff = Staff.find(params[:id])
  end
  
  def update
    staff = Staff.find(params[:id])
    if staff.update(staff_params)
      flash[:notice] = "You have updated staff successfully."
    end
    redirect_to staffs_path
  end
  
  def destroy
    staff = Staff.find(params[:id])
    if staff.destroy
      flash[:notice] = "You have delete staff successfully."
    end
    redirect_to staffs_path
  end
  
  private
  
  def staff_params
    params.require(:staff).permit(:name, :holiday)
  end
  
end
