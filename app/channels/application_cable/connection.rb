module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user
    identified_by :chat_room

    def connect
      begin
        reject_unauthorized_connection unless current_user
        chat_room.user_ids
        reject_unauthorized_connection unless chat_room.user_ids.include? current_user.id
      rescue Exception => e
        puts e.message
        reject_unauthorized_connection
      end
    end

    private

      def current_user
        @current_user ||= current_session.user if current_session
        @current_user
      end

      def current_session
        @current_session ||= Session.find_by_token(cookies.permanent[:session_token])
      end

      def current_user=(user)
        @current_user = user
      end

      def chat_room
        @chat_room ||= ChatRoom.find_by_id cookies.permanent[:chat_room_id]
      end
  end
end
