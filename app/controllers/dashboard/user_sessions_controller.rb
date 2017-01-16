class Dashboard::UserSessionsController < Dashboard::BaseController
  def destroy
    logout
    redirect_to login_path, notice: t(:log_out_is_successful_notice)
  end
end
