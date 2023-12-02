class ReservationsController < ApplicationController
  before_action :get_current_user
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]

  def index
    @reservations = @user.reservations
    @room = @user.rooms
  end

  def new
    @reservation = Reservation.new
  end

  def confirm
    @reservation = Reservation.new(reservation_params)
    @room = Room.find_by(id: @reservation.room_id)
    if @reservation.checkin_date.present? && @reservation.checkout_date.present?
      @days = (@reservation.checkout_date - @reservation.checkin_date).to_i
      @total_fee = @room.fee * @days * @reservation.headcount
    end
    if @reservation.invalid?
      render "rooms/show"
    end
  end

  def create
    @reservation = Reservation.new(reservation_params)
    @room = Room.find_by(id: @reservation.room_id)
    if @reservation.save
      redirect_to reservations_path
    else
      render "rooms/show"
    end
  end

  def show
  end

  def edit
    @reservation = Reservation.find_by(id: params[:id])
    @room = Room.find_by(id: @reservation.room.id)
  end

  def update
    @reservation = Reservation.find_by(id: params[:id])
    @room = Room.find_by(id: @reservation.room.id)
    if @reservation.update(reservation_params)
      redirect_to reservations_path
    else
      render "reservations/edit"
    end
  end

  def destroy
    @reservation = Reservation.find_by(id: params[:id])
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

  def ensure_correct_user
    @reservation = Reservation.find_by(id: params[:id])
    if @reservation.nil?
      redirect_to root_path
    else
      unless @reservation.user_id == @user.id
        flash[:notice] = "権限がありません"
        redirect_to reservations_path
      end
    end
  end
  
end
