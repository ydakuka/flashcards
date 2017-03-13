class ApplicationController < ActionController::Base
  include ApiFlashcards
  include Pundit
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  protect_from_forgery with: :exception
  before_action :set_locale

  private

  def set_locale
    locale = choose_locale

    if locale && I18n.available_locales.include?(locale.to_sym)
      session[:locale] = I18n.locale = locale || I18n.default_locale
    end
  end

  def choose_locale
    case
    when current_user then current_user.locale
    when params[:user_locale] then params[:user_locale]
    when session[:locale] then session[:locale]
    else http_accept_language.compatible_language_from(I18n.available_locales)
    end
  end

  def default_url_options(options = {})
    { locale: I18n.locale }.merge options
  end

  def user_not_authorized
    flash[:alert] = I18n.t(:not_authorized_alert)
    redirect_to(request.referrer || root_path)
  end
end
