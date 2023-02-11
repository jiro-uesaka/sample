class WorkPatternsController < ApplicationController
  
  def index
    @work_patterns = WorkPattern.where(user_id: current_user.id)
    @work_pattern = WorkPattern.new
  end
  
  def create
    work_pattern = WorkPattern.new(work_pattern_params)
    work_pattern.user_id = current_user.id
    if work_pattern.save
      flash[:notice] = "You have created work_pattern successfully."
    end
    redirect_to request.referer
  end
  
  def edit
    @work_pattern = WorkPattern.find(params[:id])
  end
  
  def update
    work_pattern = WorkPattern.find(params[:id])
    if work_pattern.update(work_pattern_params)
      flash[:notice] = "You have updated work_pattern successfully."
    end
    redirect_to work_patterns_path
  end
  
  def destroy
    work_pattern = WorkPattern.find(params[:id])
    if work_pattern.destroy
      flash[:notice] = "You have delete work_pattern successfully."
    end
    redirect_to work_patterns_path
  end
  
  private
  
  def work_pattern_params
    params.require(:work_pattern).permit(:name)
  end
end