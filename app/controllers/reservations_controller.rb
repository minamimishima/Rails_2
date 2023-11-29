class ReservationsController < ApplicationController
  before_action :get_current_user

  def index
    @reservations = @user.reservations
    @room = @user.rooms
  end

  def new
    @reservation = Reservation.new
  end

  def confirm
    @reservation = Reservation.new(reservation_params)
    @room = Room.find(@reservation.room_id)
    if @reservation.invalid?
      render "rooms/show"
    end
  end

  def create
    @reservation = Reservation.new(reservation_params)
    @room = Room.find(@reservation.room_id)
    if @reservation.save
      redirect_to reservations_path
    else
      render "rooms/show"
    end
  end

  def show
    
  end

  def edit
    @reservation = Reservation.find(params[:id])
  end

  def update
    @reservation = Reservation.find(params[:id])
    if @reservation.update(reservation_params)
      redirect_to reservations_path
    else
      render "reservations/edit"
    end
  end

  def destroy
    @reservation = Reservation.find(params[:id])
    if @reservation.destroy
      redirect_to reservations_path
    else
      render "rooms/show"
    end
  end

  private
  def get_current_user
    @user = current_user
  end

  def reservation_params
    params.require(:reservation).permit(:checkin_date, :checkout_date, :headcount, :user_id, :room_id)
  end

end
