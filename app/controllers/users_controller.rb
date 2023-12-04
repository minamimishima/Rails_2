class UsersController < ApplicationController
  before_action :authenticate_user!
  
  def account_show
    @user = current_user
  end

  def profile_show
    @user = current_user
  end

  def profile_edit
    @user = current_user
  end

  def profile_update
    @user = current_user
    if @user.update(profile_params)
      redirect_to profile_path
    else
      render "profile_edit"
    end
  end

private

  def profile_params
    params.require(:user).permit(:name, :image, :introduction)
  end

end
