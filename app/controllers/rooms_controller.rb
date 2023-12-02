class RoomsController < ApplicationController
  before_action :get_current_user
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]

  def index
    @rooms = Room.all
  end

  def new
    @room = Room.new
  end

  def create
    @room = Room.new(room_params)
    if @room.save
      redirect_to room_path(@room)
    else
      render "new"
    end
  end

  def show
    @room = Room.find_by(id:params[:id])
    @reservation = Reservation.new
    if @room == nil
      redirect_to root_path
    end
  end

  def edit
    @room = Room.find_by(id: params[:id])
    if @room == nil
      redirect_to root_path
    end
  end

  def update
    @room = Room.find_by(id: params[:id])
    if @room.update(room_params)
      redirect_to room_path(@room)
    else
      render "edit"
    end
  end

  def destroy
    @room = Room.find_by(id: params[:id])
    if @room.destroy
      redirect_to rooms_own_path
    else
      render "own"
    end
  end

  def own
    if user_signed_in?
      @rooms = @user.rooms
    else
      flash[:notice] = "ログインしてください"
      redirect_to root_path
    end
  end

  private
  def get_current_user
    @user = current_user
  end

  def room_params
    params.require(:room).permit(:room_name, :address, :fee, :room_detail, :room_image, :user_id)
  end

  def ensure_correct_user
    @room = Room.find_by(id: params[:id])
    if @room == nil
      redirect_to root_path
    elsif @room.user_id != @user.id
      flash[:notice] = "権限がありません"
      redirect_to room_path(@room.id)
    end
  end

end
