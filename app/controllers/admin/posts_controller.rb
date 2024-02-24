class Admin::PostsController < ApplicationController
  before_action :authenticate_admin!
  def show
    @post = Post.find(params[:id])
    @end_user = @post.end_user
    @game_bookmarks = @end_user.game_bookmarks.all
    @comments = @post.comments.where(is_deleted: false)
  end
  def destroy
    post = Post.find(params[:id])
    post.update(is_deleted: true)
    post.comments.each do |comment|
      comment.update(is_deleted: true)
    end
    flash[:notice] = "投稿を削除しました。"
    redirect_to admin_post_path(post.id)
  end
end
