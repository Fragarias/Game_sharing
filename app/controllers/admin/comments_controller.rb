class Admin::CommentsController < ApplicationController
  before_action :authenticate_admin!
  def destroy
    comment = Comment.find(params[:id])
    comment.update(is_deleted: true)
    flash[:notice] = "コメントを削除しました。"
    redirect_to admin_post_path(params[:post_id])
  end
end
