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
    @headcount = @shift.headcount
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
    headcount = Headcount.new
    headcount.shift_id = shift.id
    max_worker = shift.shop.max_worker
    min_worker = shift.shop.min_worker
    day = 1
    month_day = 0
    case shift.month
      when 2 then
        month_day = 28
      when 4 , 6 , 9 , 11 then
        month_day = 30
      else
        month_day = 31
    end
    while day <= month_day do
      headcount.send("day#{day}_max=",max_worker)
      headcount.send("day#{day}_min=",min_worker)
      day += 1
    end
    headcount.save
    redirect_to shift_path(shift.id)
  end

  def edit
  end
  
  def calculate
    shift = Shift.find(params[:id])
    headcount = shift.headcount
    workers = shift.workers
    month_day = 0
    case shift.month
      when 2
        month_day = 28
      when 4 , 6 , 9 , 11
        month_day = 30
      else
        month_day = 31
    end
    workers.each do |worker|
      if worker.staff.holiday == 0
        worker.holiday = shift.shop.holiday
      else
        worker.holiday = worker.staff.holiday
      end
      worker.save
      day = 1
      while day <= month_day do
        if worker.send("day#{day}").nil?
          worker.send("day#{day}=",2)
        elsif worker.send("day#{day}") == 3 && worker.holiday > 0
          worker.decrement!(:holiday, 1)
        end
        worker.save
        day += 1
      end
    end
    # [日時処理]
    # 月末まで処理を繰り返す
    
    day = 1
    while day <= month_day do
      # スタッフの残休日数(Worker.holiday)が全員0以下かを取得
      all_holiday = 0
      workers.each do |worker|
        if worker.holiday > 0
          all_holiday = 1
        end
      end
      # その日の現時点での出勤人数を取得
      worker_count = 0
      workers.each do |worker|
        if worker.send("day#{day}") == 2 || worker.send("day#{day}") == 4
          worker_count += 1
        end
      end
        # スタッフの残休日数が全員０以下の場合  
      if all_holiday == 0
        # 　その日の現在の勤務者数＞その日の最大勤務者数になるか確認  
        if worker_count > headcount.send("day#{day}_max")
      # 　なる場合、各スタッフの残休日数を比較し、一番多いスタッフ（同数ならIDの若いスタッフ）の「day_x_」を休に  
          most_holiday = workers.maximum(:holiday)
          day_process = "unclear"
          count = 0
          while day_process == "unclear" && count <= 31 do
            workers.each do |worker|
              if worker.holiday == most_holiday && worker.send("day#{day}") == 2
                worker.send("day#{day}=",1)
                worker.decrement!(:holiday, 1)
                worker.save
                day_process = "clear"
                break
              end
            end
            most_holiday -= 1
            count += 1
          end
          day += 1
        # 　（残休日数は０なので-1になる）  
        # 　ならなければ翌日の処理に移る  
        else
          day += 1
        # 　なお、該当スタッフがすでに休になっている場合、次に残休日数が多い（複数名が該当する場合その中でIDが若い）スタッフに休を入れ翌日へ  
        # 　（残休日数は０なので-1になる）  
        end
        # 一人でも１以上の場合  
      else
        # 　その日の現在の勤務者数-1≧その日の最低勤務者数になるか確認  
        if (worker_count - 1) >= headcount.send("day#{day}_min")
        # 　なる場合、各スタッフの残休日数を比較し、一番多いスタッフ（同数ならIDの若いスタッフ）の「○day_rest（もしくは中間テーブル）」を休に  
          most_holiday = workers.maximum(:holiday)
          day_process = "unclear"
          count = 0
          while day_process == "unclear" && count <= 31 do
            workers.each do |worker|
              if worker.holiday == most_holiday && worker.send("day#{day}") == 2
                worker.send("day#{day}=",1)
                worker.decrement!(:holiday, 1)
                worker.save
                day_process = "clear"
                break
              end
            end
            most_holiday -= 1
            count += 1
          end
          day += 1
        # 　ならなければ翌日の処理に移る  
        else
          day += 1
        # 　なお、該当スタッフがすでに休になっている場合、次に残休日数が多い（複数名が該当する場合その中でIDが若い）スタッフに休を入れ翌日へ  
        # 　その場合、次に残休日数が多いスタッフの残休日数が０以下でも休を入れる（0だったら-1になる）
        end
      end
    end
    # [月末処理]
    day = 1
    month_process = ""
    # 全スタッフの残休日数を確認 
    all_holiday = 0
    workers.each do |worker|
      if worker.holiday > 0
        all_holiday = 1
      end
    end
    #   スタッフの残休日数が全員０以下  
    if all_holiday == 0
    #   　「その日の出勤人数＞その日の最大勤務者数」が１日でも存在する（最大勤務日数よりも出勤可能数が多い） 
      while day <= month_day do
        worker_count = 0
        workers.each do |worker|
          if worker.send("day#{day}") == 2 || worker.send("day#{day}") == 4
            worker_count += 1
          end
        end
        if worker_count > headcount.send("day#{day}_max")
          month_process = "repeat"
        end
        day += 1
      end
    #   　　再度月初から日次処理  
    #   　「その日の出勤人数＞その日の最大勤務者数」が１日も存在しないか、存在しても休日を設定不可
      if month_process != "repeat" || count > 31
    #   　　残休日数が一番多い（シフト上の休日が少ない）スタッフと少ない（シフト上の休日が多い）スタッフの差を比較する  
        loop do
          most_holiday = workers.maximum(:holiday)
          least_holiday = workers.minimum(:holiday)
          subtraction = most_holiday - least_holiday
          case subtraction
      #   　　差が０  
            when 0
      #   　　　仮出力画面に遷移する  
              workers.each do |worker|
                worker.save
              end
              redirect_to preview_path(shift.id)
              return
      #   　　差が絶対値で１（最大出勤者数を満たすために設定公休数より休みが多い状態）  
            when 1
      #   　　　休日数が一番多いスタッフが休になっている日で現在の出勤者数+1≦最大勤務者数を満たす日がないか１日から確認  
      #   　　　あればその日の休を出勤に変更  
              day = 1
              available_day = 0
              month_process = "repeat"
              while day <= month_day && month_process == "repeat" do
                worker_count = 0
                workers.each do |worker|
                  if worker.send("day#{day}") == 2 || worker.send("day#{day}") == 4
                    worker_count += 1
                  end
                end
                if (worker_count + 1) <= headcount.send("day#{day}_max")
                  available_day = 1
                  workers.each do |worker|
                    if worker.holiday == most_holiday && worker.send("day#{day}") == 1
                      worker.send("day#{day}=",2)
                      worker.increment!(:holiday, 1)
                      worker.save
                      month_process = "clear"
                      break
                    end
                  end
                end
                day += 1
              end
      #   　　　なければ全ての日にちで現在の出勤者数+1≦最大勤務者数になるか確認する  
      #   　　　条件に該当する（出勤が一人増えても最大勤務者数を超えない）日がある場合、  
      #   　　　その日の休になっている一番IDの若いスタッフを出勤に変えて修正テーブルを起動  
              day = 1
              if month_process == "repeat" && available_day == 1
                while day <= month_day && month_process == "repeat" do
                  worker_count = 0
                  workers.each do |worker|
                    if worker.send("day#{day}") == 2 || worker.send("day#{day}") == 4
                      worker_count += 1
                    end
                  end
                  if (worker_count + 1) <= headcount.send("day#{day}_max")
                    workers.each do |worker|
                      if worker.send("day#{day}") == 1
                        worker.send("day#{day}=",2)
                        worker.increment!(:holiday, 1)
                        worker.save
                        month_process = "clear"
                        break
                      end
                    end
                  end
                  day += 1
                end
              end
      #   　　　全ての日で条件に該当する場合、エラーメッセージと共にそのまま仮出力画面へ
              if month_process == "repeat"
                flash[:notice] = "休日数が不均等です"
                workers.each do |worker|
                  worker.save
                end
                redirect_to preview_path(shift.id)
                return
              end
      #   　　差が絶対値で２以上なら修正テーブルを起動  
            else
              count = 1
              month_process = "repeat"
              while count <= 31 do
                day = 1
                while day <= month_day && month_process == "repeat" do
                  workers.each do |worker_most|
                    if worker_most.holiday == most_holiday && worker_most.send("day#{day}") == 2
                      workers.each do |worker_least|
                        if worker_least.holiday == least_holiday && worker_least.send("day#{day}") == 1
                          worker_most.send("day#{day}=",1)
                          worker_most.save
                          worker_least.send("day#{day}=",2)
                          worker_least.save
                          month_process = "clear"
                          break
                        end
                      end
                      break
                    end
                  end
                  day += 1
                end
                if month_process == "repeat"
                  least_holiday += 1
                  count += 1
                end
                if most_holiday == least_holiday
                  flash[:notice] = "休日数がとても不均等です"
                  workers.each do |worker|
                    worker.save
                  end
                  redirect_to preview_path(shift.id)
                  return
                end
              end
      #   　　　試行回数ｎに+1  
      #   　　　休日数がｎ番目に多いスタッフと一番少ないスタッフのIDを格納する  
      #   　　　「休日数がｎ番目に多いスタッフが休になっていて、かつ一番少ないスタッフが出勤になっている」日にちがないか確認する  
      #   　　　あった場合、休日数がｎ番目に多いスタッフを出勤に変更し一番少ないスタッフを休日にする  
      #   　　　その上で再度処理を行う  
      #   　　　なかった場合、試行回数ｎに+1から繰り返す  
      #   　　　もし勤務可能スタッフ数と同じ回数試行しても上手くいかなければエラーメッセージと共に仮出力画面に遷移する  
          end
        end
      end
    #   スタッフの残休日数が一人でも１以上  
    else
    #   　「その日の出勤人数-1≧その日の最低勤務者数」が１日でも存在する  
      while day <= month_day do
        worker_count = 0
        workers.each do |worker|
          if worker.send("day#{day}") == 2 || worker.send("day#{day}") == 4
            worker_count += 1
          end
        end
        if (worker_count - 1) >= headcount.send("day#{day}_min")
          month_process = "repeat"
        end
        day += 1
      end
    #   　　再度月初から日次処理  
      if month_process != "repeat" || count > 31
    #   　「その日の出勤人数-1≧その日の最低勤務者数」が１日も存在しない（現在の公休数では最低勤務日数を満たせない）  
    #   　　残休日数が一番多い（シフト上の休日が少ない）スタッフと少ない（シフト上の休日が多い）スタッフの差を絶対値で比較する
        loop do
          most_holiday = workers.maximum(:holiday)
          least_holiday = workers.minimum(:holiday)
          subtraction = most_holiday - least_holiday
          case subtraction
    #   　　差が０  
    #   　　　エラーメッセージと共に仮出力画面に遷移する
            when 0
              workers.each do |worker|
                worker.save
              end
              flash[:notice] = "休日数が余ってしまいました"
              redirect_to preview_path(shift.id)
              return
    #   　　差が絶対値で１（１以上なので+1：最低出勤者数を満たすために設定公休数より休みが少ない状態）  
    #   　　　休日数が一番少ないスタッフが出勤になっている日で現在の出勤者数-1＜最低勤務者数を満たさない日がないか１日から確認  
    #   　　　あればその日の出勤を休に変更  
    #   　　　なければ全ての日にちで現在の出勤者数-1≧最低勤務者数になるか確認する  
    #   　　　条件に該当する（出勤が一人減っても最低勤務者数を割らない）日がある場合、  
    #   　　　その日の出勤になっている一番IDの若いスタッフを休に変えて修正テーブルを起動  
    #   　　　全ての日で条件に該当しない場合、エラーメッセージと共にそのまま仮出力画面へ  
            when 1
              day = 1
              available_day = 0
              month_process = "repeat"
              while day <= month_day && month_process == "repeat" do
                worker_count = 0
                workers.each do |worker|
                  if worker.send("day#{day}") == 2 || worker.send("day#{day}") == 4
                    worker_count += 1
                  end
                end
                if (worker_count - 1) >= headcount.send("day#{day}_min")
                  available_day = 1
                  workers.each do |worker|
                    if worker.holiday == most_holiday && worker.send("day#{day}") == 2
                      worker.send("day#{day}=",1)
                      worker.decrement!(:holiday, 1)
                      worker.save
                      month_process = "clear"
                      break
                    end
                  end
                end
                day += 1
              end
              day = 1
              if month_process == "repeat" && available_day == 1
                while day <= month_day && month_process == "repeat" do
                  worker_count = 0
                  workers.each do |worker|
                    if worker.send("day#{day}") == 2 || worker.send("day#{day}") == 4
                      worker_count += 1
                    end
                  end
                  if (worker_count - 1) >= headcount.send("day#{day}_min")
                    workers.each do |worker|
                      if worker.send("day#{day}") == 2
                        worker.send("day#{day}=",1)
                        worker.decrement!(:holiday, 1)
                        worker.save
                        month_process = "clear"
                        break
                      end
                    end
                  end
                  day += 1
                end
              end
              if month_process == "repeat"
                flash[:notice] = "休日数が不均等です"
                workers.each do |worker|
                  worker.save
                end
                redirect_to preview_path(shift.id)
                return
              end
            else
    #   　　差が絶対値で２以上なら修正テーブルを起動  
    #   　　　試行回数ｎに+1  
    #   　　　休日数がｎ番目に多いスタッフと一番少ないスタッフのIDを格納する  
    #   　　　「休日数がｎ番目に多いスタッフが休になっていて、かつ一番少ないスタッフが出勤になっている」日にちがないか確認する  
    #   　　　あった場合、休日数がｎ番目に多いスタッフを出勤に変更し一番少ないスタッフを休日にする  
    #   　　　その上で再度月末処理を行う  
    #   　　　なかった場合、試行回数ｎに+1から繰り返す  
    #   　　　もし勤務可能スタッフ数と同じ回数試行しても上手くいかなければエラーメッセージと共に仮出力画面に遷移する  
              count = 1
              month_process = "repeat"
              while count <= 31 do
                day = 1
                while day <= month_day && month_process == "repeat" do
                  workers.each do |worker_most|
                    if worker_most.holiday == most_holiday && worker_most.send("day#{day}") == 2
                      workers.each do |worker_least|
                        if worker_least.holiday == least_holiday && worker_least.send("day#{day}") == 1
                          worker_most.send("day#{day}=",1)
                          worker_most.save
                          worker_least.send("day#{day}=",2)
                          worker_least.save
                          month_process = "clear"
                          break
                        end
                      end
                      break
                    end
                  end
                  day += 1
                end
                if month_process == "repeat"
                  least_holiday += 1
                  count += 1
                end
                if most_holiday == least_holiday
                  flash[:notice] = "休日数がとても不均等です"
                  workers.each do |worker|
                    worker.save
                  end
                  redirect_to preview_path(shift.id)
                  return
                end
              end
          end
        end
      end
    end
  end

  def preview
    @shift = Shift.find(params[:id])
    @workers = Worker.where(shift_id: @shift.id)
    @work_patterns = WorkPattern.where(user_id: current_user.id)
  end
  
  private
  
  def shift_params
    params.require(:shift).permit(:shop_id, :year, :month)
  end
  
end
