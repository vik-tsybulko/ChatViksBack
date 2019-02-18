class Api::BaseController < ApplicationController

  before_action :set_default_response_format
  skip_before_action :verify_authenticity_token

  protected

  def set_default_response_format
    request.format = :json
    response.headers['Access-Control-Allow-Origin'] = 'http://localhost:3000'
    response.headers['Access-Control-Allow-Methods'] = 'POST, PUT, DELETE, GET, OPTIONS'
    response.headers['Access-Control-Allow-Credentials'] = 'true'
    response.headers['Access-Control-Request-Method'] = '*'
    response.headers['Access-Control-Allow-Headers'] = 'Origin, X-Requested-With, Content-Type, Accept, Authorization Set-Cookie'
  end

  rescue_from Exception, with: :catch_exceptions

  def authenticate_user
    render json: {errors: ["message": "Access denied."]}, status: :forbidden and return unless current_session
  end

  private

  def catch_exceptions(e)
    logger.error e.message
    logger.error e.backtrace.join("\n")

    case e.class.name
      when 'Net::SMTPSyntaxError'
        render json: {errors: ['Emails is not configured.']}, status: :unprocessable_entity
      when 'CanCan::AccessDenied'
        render json:{errors: [e.message]}, status: 403
      else
        render json: {errors: [{message: e.message}]}, status: :unprocessable_entity
    end
  end
end
