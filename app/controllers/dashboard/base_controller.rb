class Dashboard::BaseController < ApplicationController
  before_action :require_login, :track_action
  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  protected

  def track_action
    if current_user
      ahoy.authenticate(current_user)
      ahoy.track "Viewed #{controller_name}##{action_name}", user_id: current_user.id
    end
  end

  private

  def not_authenticated
    redirect_to login_path, alert: t(:please_log_in)
  end

  def not_found
    flash[:alert] = t(:not_found_alert)
    redirect_to root_path
  end
end
