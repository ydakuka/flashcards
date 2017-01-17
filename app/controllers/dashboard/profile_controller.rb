class Dashboard::ProfileController < Dashboard::BaseController

  def edit
  end

  def update
    if current_user.update(user_params)
      redirect_to edit_profile_path,
                  notice: 'Профиль пользователя успешно обновлен.'
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation,
                                 :locale)
  end
end
