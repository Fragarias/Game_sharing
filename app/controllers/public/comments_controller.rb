class Public::CommentsController < ApplicationController
  before_action :authenticate_end_user!
end
