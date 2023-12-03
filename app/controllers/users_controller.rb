class UsersController < ApplicationController
  before_action :authenticate_user!
  
  def index
  end

  def new
  end

  def create
  end

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

  def destroy
  end

private

  def profile_params
    params.require(:user).permit(:name, :image, :introduction)
  end

end
