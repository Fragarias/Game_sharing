class Admin::PostsController < ApplicationController
  before_action :authenticate_admin!
  def show
    @post = Post.find(params[:id])
    @end_user = @post.end_user
    @game_bookmarks = @end_user.game_bookmarks.all
  end
end
