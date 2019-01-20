class MessagesController < ApplicationController
  load_and_authorize_resource

  def create
    if @message.save
      ActionCable.server.broadcast 'messages',
                                   message: @message.message,
                                   user: current_user.first_name,
                                   message_type: @message.message_type,
                                   ui_id: @message.ui_id
      head :ok
      render json: { message: 'Message was created' }
    else
      render json: { errors: @message.errors }, status: :bad_request
    end
  end

  def message_params
    allowed_params = params.permit :message, :chat_room_id, :message_type, :ui_id
    allowed_params[:user_id] = current_user.id
    allowed_params
  end
end
