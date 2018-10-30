class Api::V1::SessionsController < Api::V1::BaseController
  skip_before_action :authenticate_user, except: :destroy

  def create
    @user = User.find_by_email params[:email]
    if @user
      if @user.authenticate params[:password]
        sign_in user: @user, device_type: params[:device_type], push_token: params[:push_token]
        render json: { session_token: current_session.token, user: current_user.to_json }
      else
        render json: {errors: [{message: "Wrong password"}]}, status: :bad_request
      end
    else
      render json: {errors: [{message: "User by given email not found"}]}, status: :bad_request
    end
  end

  def destroy
    sign_out
    render json: {message: 'Logout successful'}
  end
end
