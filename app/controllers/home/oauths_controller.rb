class Home::OauthsController < Home::BaseController
  def oauth
    login_at(auth_params[:provider])
  end

  def callback
    provider = auth_params[:provider]
    if @user = login_from(provider)
      ahoy.track "Logged with github", user_id: @user.id
      redirect_to_trainer(provider)
    else
      begin
        @user = create_from(provider)
        reset_session
        auto_login(@user)
        ahoy.track "Logged with github", user_id: @user.id
        redirect_to_trainer(provider)
      rescue
        redirect_to user_sessions_path, alert: (t 'log_out_failed_provider_alert',
                                        provider: provider.titleize)
      end
    end
  end

  private

  def auth_params
    params.permit(:code, :provider)
  end

  def redirect_to_trainer(provider)
    redirect_to trainer_path, notice: (t 'log_in_is_successful_provider_notice',
                              provider: provider.titleize)
  end
end
