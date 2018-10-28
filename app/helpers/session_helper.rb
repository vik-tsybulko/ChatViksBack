module SessionHelper
  def sign_in(user:, push_token: nil, device_type: nil)
    @current_session = user.sessions.create! push_token: push_token, device_type: device_type
    cookies.permanent[:session_token] = @current_session.token
    self.current_user = user

    #https://content-security-policy.com/
    response.set_header('Content-Security-Policy', "default-src 'self'; font-src 'self' fonts.googleapis.com/css; style-src 'self' fonts.googleapis.com/css")
    current_session
  end

  def signed_in?
    !current_user.nil?
  end

  def current_user
    @current_user ||= current_session.user if current_session && !current_session.destroyed?
    @current_user
  end

  def current_session
    @current_session ||= Session.find_by_token([request.headers['Session-Token'], cookies.permanent[:session_token], params[:session_token]].compact.first)
  end

  def sign_out
    current_session.destroy if current_session
    cookies.permanent[:session_token] = nil
    self.current_user = nil
  end

  def current_user=(user)
    @current_user = user
  end

end