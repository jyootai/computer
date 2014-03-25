class UsersController < ApplicationController
  def new
    @user=User.new
  end

  def create
    @user=User.new params.require(:user).permit(:username,:email,:name,:password,
					       :password_confirmation)
    if @user.save
      sign_in @user
      redirect_to @user
    else
      render 'new'
    end
  end

  def show
  end
end
