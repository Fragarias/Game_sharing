class Public::NotificationsController < ApplicationController
  before_action :authenticate_end_user!
  def index
  end
end
