class ReservationsController < ApplicationController
  # before_action :authenticate_user!
  load_and_authorize_resource

  def index
    @user = current_user
    @reservations = if @user.role == 'admin'
                      Reservation.all
                    else
                      Reservation.where(user_id: current_user.id)
                    end
    render json: { reservations: @reservations }, status: :ok
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
