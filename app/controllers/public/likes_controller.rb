class Public::LikesController < ApplicationController
  before_action :authenticate_end_user!
end
