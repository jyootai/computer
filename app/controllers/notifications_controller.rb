class NotificationsController < ApplicationController
  before_action :required_login

  def index
    @notifications = current_user.notifications.order(id: :desc).page(params[:page])
  end

  def destroy
    @notification = current_user.notifications.find params[:id]
    @notification.destroy

    respond_to do |format|
      format.js
    end
  end

  def clear
    current_user.notifications.delete_all

    respond_to do |format|
      format.js
    end
  end
end
