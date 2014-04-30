class Settings::ProfilesController < Settings::ApplicationController
  before_action :required_current_password, only: [:update]

  def show
  end

  def update
    if @user.update_attributes params.require(:user).permit(:name, :email, :password,:professional,
							    :avatar,:remove_avatar,
							    :bio, :password_confirmation)
      flash[:success]=  I18n.t('settings.flashes.successfully_updated')
      redirect_to settings_profile_path
    else
      render 'show'
    end
  end

end
