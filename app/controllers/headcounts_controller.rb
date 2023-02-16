class HeadcountsController < ApplicationController
  def edit
    @shift = Shift.find(params[:shift_id])
    @headcount = Headcount.where(shift_id: @shift.id)
  end
  
  def update
    headcount = Headcount.where(shift_id: params[:shift_id])
    if headcount.update(headcount_params)
      flash[:notice] = "You have updated headcount successfully."
    end
    redirect_to shift_path(params[:shift_id])
  end
  
  def headcount_params
    params.require(:headcount).permit(:shift_id, :day1_max, :day1_min, :day2_max, :day2_min, :day3_max, :day3_min, :day4_max, :day4_min, :day5_max, :day5_min, :day6_max, :day6_min, :day7_max, :day7_min, :day8_max, :day8_min, :day9_max, :day9_min, :day10_max, :day10_min,
    :day11_max, :day11_min, :day12_max, :day12_min, :day13_max, :day13_min, :day14_max, :day14_min, :day15_max, :day15_min, :day16_max, :day16_min, :day17_max, :day17_min, :day18_max, :day18_min, :day19_max, :day19_min, :day20_max, :day20_min,
    :day21_max, :day21_min, :day22_max, :day22_min, :day23_max, :day23_min, :day24_max, :day24_min, :day25_max, :day25_min, :day26_max, :day26_min, :day27_max, :day27_min, :day28_max, :day28_min, :day29_max, :day29_min, :day30_max, :day30_min, :day31_max, :day31_min)
  end
end
