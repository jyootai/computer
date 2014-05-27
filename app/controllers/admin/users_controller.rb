class Admin::UsersController < Admin::ApplicationController
  before_action :find_user, except: [:index, :locked]

  def index
    @users=User.page(params[:page])
  end

  def show
  end

  def locked
    @users = User.locked.order(id: :desc).page(params[:page])
    render :index
  end

  def lock
    @user.lock
    flash[:success] = I18n.t('settings.flashes.successfully_locked')
    redirect_to admin_user_url(@user)
  end

  def unlock
    @user.unlock
    flash[:success] = I18n.t('settings.flashes.successfully_unlocked')
    redirect_to admin_user_url(@user)
  end

  def destroy
    @user.destroy
    redirect_to admin_users_path
  end

  def update
    if @user.update_attributes params.require(:user).permit(:name, :username, :email, :bio, :avatar)
      flash[:success]= I18n.t('settings.flashes.successfully_updated') 
      redirect_to admin_user_url(@user)
    else
      render :show
    end
  end

  private
    def find_user
      @user=User.find params[:id]
    end
end
