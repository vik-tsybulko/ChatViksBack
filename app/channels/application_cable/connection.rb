module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    def connect
      begin
        reject_unauthorized_connection unless current_user
      rescue Exception => e
        e.message
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
  end
end
