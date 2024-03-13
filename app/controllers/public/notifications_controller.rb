class Public::NotificationsController < ApplicationController
  before_action :authenticate_end_user!
  def index
    @notifications = current_end_user.passive_notifications
    # @notifications.where(is_checked: false).each do |notification|
    #   notification.update(is_checked: true)
    # end
  end
end
