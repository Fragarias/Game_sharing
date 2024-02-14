class Public::GameBookmarkController < ApplicationController
  before_action :authenticate_end_user!
end
