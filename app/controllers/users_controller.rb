class UsersController < ApplicationController
  def edit
    @user = current_user
  end
  def update
    user = current_user
    if user.update(user_params)
      flash[:notice] = "You have updated user successfully."
    end
    redirect_to request.referer
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name)
  end
  
end
