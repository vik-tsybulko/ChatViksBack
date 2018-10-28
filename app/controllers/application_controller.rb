class ApplicationController < ActionController::Base

  include ApplicationHelper
  include SessionHelper

  before_action :set_locale
  before_action :authenticate_user

  protect_from_forgery with: :exception

  rescue_from Exception, with: :catch_exceptions

  def authenticate_user
    respond_with_errors unless current_session
  end

  protected

    def respond_with_errors
      render json: {errors: I18n.t('headers.access_denied') }, status: :unauthorized
    end

  private

    def catch_exceptions(e)
      logger.error e.message
      logger.error e.backtrace.join("\n")

      case e.class.name
      when 'ActiveRecord::RecordNotFound'
        render json: {errors: [e.message]}, status: :not_found
      when 'ArgumentError'
        render json: {errors: [e.message]}, status: :unprocessable_entity
      when 'CanCan::AccessDenied'
        render json:{errors: [e.message]}, status: :forbidden
      else
        render json: {errors: [e.message]}, status: 499
      end
    end

    def set_locale
      locale = params[:locale] || cookies.permanent[:locale ] || 'en'
      locale = "en" unless I18n.available_locales.map(&:to_s).include?(locale)
      I18n.locale = locale
      cookies.permanent[:locale] = I18n.locale
    end
end
