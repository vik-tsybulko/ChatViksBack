class Api::V1::ChatRoomsController < Api::V1::BaseController
  load_and_authorize_resource

  def index
    @chat_rooms = current_user.chat_rooms
  end

  def create
    if @chat_room.save!
      render json: { message: 'Success', chat_room: @chat_room.to_json }
    else
      render json: { errors: [@chat_room.errors] }, status: :bad_request
    end
  end

  def show

  end

  def update

  end

  def destroy

  end

  private

  def chat_room_params
    allowed_params = params.permit :title, :chat_room_type, :avatar, user_ids: []
    allowed_params[:user_ids] << current_user.id

    allowed_params
  end

end
