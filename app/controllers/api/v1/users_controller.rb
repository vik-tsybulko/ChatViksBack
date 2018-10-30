class Api::V1::UsersController < Api::V1::BaseController

  load_and_authorize_resource :user, only: [:show, :update]

  skip_before_action :authenticate_user, only: :create

  def create
    @user = User.new user_params
    if @user.save
      @message = 'User is created'
      render 'show'
    else
      render json: {errors: [@user.errors]}, status: :unprocessable_entity
    end
  end

  def show

  end

  def update
    @user = current_user
    if @user.update_attributes user_params
      render 'show'
    else
      render json: {errors: [@user.errors]}, status: :unprocessable_entity
    end
  end

  def profile
    @user = current_user
    render :show
  end

  private

  def user_params
    allowed_params = params.permit :password, :password_confirmation, :email,
                  :first_name, :last_name, :avatar, :login, :country_id
    allowed_params[:role] = Role.get_user

    allowed_params
  end
end
