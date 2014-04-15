class SessionsController < ApplicationController
  before_action :no_logged, only: [:new, :create]
  def new
    store_location params[:return_to] 
  end
  
  def create
    user=User.find_by(username: params[:username].downcase)
    if user && user.authenticate(params[:password])
      sign_in user
      remember_me
      redirect_back_or_default root_path

    else
      flash.now[:warning]=  I18n.t('sessions.flashes.invalid')
      render 'new'
    end
  end

  def destroy
    sign_out
    redirect_to root_path
  end
end
