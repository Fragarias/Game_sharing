class Public::NotificationsController < ApplicationController
  before_action :authenticate_end_user!
  def index
    @notifications = current_end_user.passive_notifications.where(is_checked: false)
    # @notifications.where(is_checked: false).each do |notification|
    #   notification.update(is_checked: true)
    # end
  end
  def update
    notification = Notification.find(params[:id])
    notification.update(is_checked: true)
    redirect_to notifications_path
  end
  def update_all
    notifications = current_end_user.passive_notifications
    notifications.update_all(is_checked: true)
    redirect_to notifications_path
  end
end
