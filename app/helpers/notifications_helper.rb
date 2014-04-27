module NotificationsHelper

  def unread_notifications_count
    if logged_in?
      current_user.notifications.unread.count
    end
  end
end
