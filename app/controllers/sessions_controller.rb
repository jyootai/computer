class SessionsController < ApplicationController
  def new
        
  end
  
  def create
    user=User.find_by(username: params[:username].downcase)
    if user && user.authenticate(params[:password])
      sign_in user
      redirect_to root_path

    else
      flash.now[:warning]= '无效的用户名/密码'
      render 'new'
    end
  end

  def destroy
    sign_out
    redirect_to root_path
  end
end
