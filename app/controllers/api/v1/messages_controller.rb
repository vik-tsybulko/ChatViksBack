class Api::V1::MessagesController < Api::V1::BaseController
  load_and_authorize_resource

  def index
    chat_room = ChatRoom.find params[:chat_room_id]
    @messages = chat_room.messages
  end

  def create
    @messages = Message.new message_params
    if @message.save
      render json: { message: 'Message was created' }, status: :ok
    else
      render json: { errors: @message.errors }, status: :bad_request
    end
  end

  def message_params
    allowed_params = params.permit :message, :message_type, :ui_id
    allowed_params[:user_id] = current_user.id
    allowed_params[:chat_room_id] = params[:id]
    allowed_params
  end
end
