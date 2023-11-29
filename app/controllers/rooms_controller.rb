class RoomsController < ApplicationController
  before_action :get_current_user

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
    @room = Room.find(params[:id])
    @reservation = Reservation.new
  end

  def edit
    @room = Room.find(params[:id])
  end

  def update
    @room = Room.find(params[:id])
    if @room.update(room_params)
      redirect_to room_path(@room)
    else
      render "edit"
    end
  end

  def destroy
    @room = Room.find(params[:id])
    if @room.destroy
      redirect_to rooms_path
    else
      render "show"
    end
  end

  def own
    @rooms = @user.rooms
  end

  private
  def get_current_user
    @user = current_user
  end

  def room_params
    params.require(:room).permit(:room_name, :address, :fee, :room_detail, :room_image, :user_id)
  end

end
