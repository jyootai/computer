class UsersController < ApplicationController
  before_action :no_logged, only: [:new, :create]
  before_action :set_menu_active
  before_action :find_user, only: [:show, :topics]
  def new
    store_location params[:return_to]
    @user=User.new
  end

  def create
    @user=User.new params.require(:user).permit(:username,:email,:password,
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
    @topics = @user.topics.order(id: :desc)
  end

  def topics
    @topics = @user.topics.recent.paginate(:page => params[:page], :per_page => 30)
  end    


  private
    def find_user
      @user = User.where(:username=> params[:id]).first
    end

    def set_menu_active
      @current=@current=['/users']
    end
end
