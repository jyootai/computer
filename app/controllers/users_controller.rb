class UsersController < ApplicationController
  before_action :no_logged, only: [:new, :create]
  def new
    store_location params[:return_to]
    @user=User.new
  end

  def create
    @user=User.new params.require(:user).permit(:username,:email,:name,:password,
					       :password_confirmation)
    if @user.save
      sign_in @user
      redirect_to root_path
    else
      render 'new'
    end
  end

  def edit
  end
  def show
  end
end
