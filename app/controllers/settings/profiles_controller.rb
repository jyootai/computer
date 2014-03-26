class Settings::ProfilesController < Settings::ApplicationController
  before_action :required_current_password, only: [:update]

  def show
  end

  def update
    if @user.update_attributes params.require(:user).permit(:name, :email, :password, :password_confirmation)
      flash[:success]= '资料修改成功'
      redirect_to settings_profile_path
    else
      render 'show'
    end
  end

end
