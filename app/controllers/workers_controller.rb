class WorkersController < ApplicationController
  
  def create
    shift = Shift.find(params[:shift_id])
    worker = shift.workers.new(worker_params)
    if worker.save
      flash[:notice] = "You have created worker successfully."
    end
    redirect_to request.referer
  end

  def edit
      @shift = Shift.find(params[:shift_id])
      @worker = Worker.find(params[:id])
      @staffs = Staff.where(user_id: current_user.id)
      @work_patterns = WorkPattern.where(user_id: current_user.id)
  end
  
  def update
    worker = Worker.find(params[:id])
    if worker.update(worker_params)
      flash[:notice] = "You have updated worker successfully."
    end
    redirect_to shift_path(params[:shift_id])
  end

  def preview
  end
  
  private
  
  def worker_params
    params.require(:worker).permit(:staff_id, :day1, :day1_note, :day2, :day2_note, :day3, :day3_note, :day4, :day4_note, :day5, :day5_note, :day6, :day6_note, :day7, :day7_note, :day8, :day8_note, :day9, :day9_note, :day10, :day10_note,
    :day11, :day11_note, :day12, :day12_note, :day13, :day13_note, :day14, :day14_note, :day15, :day15_note, :day16, :day16_note, :day17, :day17_note, :day18, :day18_note, :day19, :day19_note, :day20, :day20_note,
    :day21, :day21_note, :day22, :day22_note, :day23, :day23_note, :day24, :day24_note, :day25, :day25_note, :day26, :day26_note, :day27, :day27_note, :day28, :day28_note, :day29, :day29_note, :day30, :day30_note, :day31, :day31_note)
  end
end
