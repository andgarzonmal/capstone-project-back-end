class RoomsController < ApplicationController
  # before_action :authenticate_user!
   load_and_authorize_resource
  
  def index
    @rooms = Room.all
    render json: { rooms: @rooms }, status: :ok
  end

  def show
    @room = Room.find_by(id: params[:id])
    render json: { room: @room }, status: :ok
  end

  def create
    @room = Room.new(room_params)
    if @room.save
      render json: { notice: 'Room created successfully!' }, status: 200
    else
      render error: { error: 'Unable to create room.' }, status: 400
    end
  end

  def destroy
    @room = Room.find_by(id: params[:id])
    if @room
      @room.destroy
      render json: { notice: 'Room deleted successfully!' }, status: 200
    else
      render json: { error: 'Unable to delete room.' }, status: 400
    end
  end

  private

  def room_params
    params.require(:room).permit(:name, :description, :photo)
  end
end
