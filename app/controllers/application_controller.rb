class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :logged_in?, :current_user



  private

  class AccessDenied < Exception; end

  def required_login
    unless logged_in?
      flash[:warning] = '请先登录'
      redirect_to login_url
    end
  end

  def required_no_locked
    if logged_in? and current_user.locked?
      raise AccessDenied
    end
  end

  def no_logged
    if logged_in?
      redirect_to root_url
      flash[:warning]= '你已经登录'
    end
  end

  def current_user
    @current_user ||= login_from_session || login_from_cookies unless defined?(@current_user)
    @current_user
  end

  def logged_in?
    !!current_user
  end

  def sign_in(user)
    session[:user_id] = user.id
    @current_user = user
  end

  def sign_out
    session.delete(:user_id)
    @current_user = nil
    forget_me
  end

  def login_from_session
    if session[:user_id].present?
      begin
        User.find session[:user_id]
      rescue
        session[:user_id] = nil
      end
    end
  end

  def login_from_cookies
    if cookies[:remember_token].present?
      if user = User.find_by_remember_token(cookies[:remember_token])
        session[:user_id] = user.id
        user
      else
        forget_me
        nil
      end
    end
  end

  def login_from_access_token
    @current_user ||= User.find_by_access_token(params[:access_token]) if params[:access_token]
  end

  def store_location(path)
    session[:return_to] = path
  end

  def redirect_back_or_default(default)
    redirect_to(session.delete(:return_to) || default)
  end

  def forget_me
    cookies.delete(:remember_token)
  end

  def remember_me
    cookies[:remember_token] = {
      value: current_user.remember_token,
      expires: 2.weeks.from_now,
      httponly: true
    }
  end
	

end
