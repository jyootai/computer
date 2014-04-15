class Settings::ApplicationController < ApplicationController
  before_action :required_login , :set_user

  private
    def set_user
      @user=current_user
    end

    def required_current_password
      unless params[:current_password] && @user.authenticate(params[:current_password])
        flash.now[:warning]= I18n.t('settings.flashes.incorrect_password')
	render 'show'
      end
    end

end
