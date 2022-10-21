class ReservationsController < ApplicationController
  # before_action :authenticate_user!
  def index
    @user = current_user
    if @user.role == 'admin'
      @reservations = Reservation.all
      render json: { reservations: @reservations }, status: :ok
      else
      @reservations = Reservation.where(user_id: current_user.id)
      render json: { reservations: @reservations }, status: :ok
    end
    
  end

  def create
    @user = current_user
    @room = Room.find_by(id: params[:room_id])
    @reservation = Reservation.new(reservation_params)
    @reservation.room_id = @room.id
    @reservation.user_id = @user.id
    if @reservation.save
      render json: { notice: 'Reservation created successfully!' }, status: 200
    else
      render error: { error: 'Unable to create reservation.' }, status: 400
    end
  end

  def destroy
    @reservation = Reservation.find_by(id: params[:id])
    if @reservation
      @reservation.destroy
      render json: { notice: 'Reservation deleted successfully!' }, status: 200
    else
      render json: { error: 'Unable to delete reservation.' }, status: 400
    end
  end

  private

  def reservation_params
    params.require(:reservation).permit(:city, :date)
  end
end
