class Public::CommentsController < ApplicationController
  before_action :authenticate_end_user!
  def create
    post = Post.find(params[:post_id])
    comment = current_end_user.comments.new(comment_params)
    comment.post_id = post.id
    if comment.save
      comment.create_notification_comment!(current_end_user, post) #comment.rb
      flash[:notice] = "コメントを送信しました。"
    else
      flash[:notice] = "コメント送信に失敗しました。"
    end
    redirect_to post_path(post.id)
  end
  def destroy
    comment = Comment.find(params[:id])
    comment.update(is_deleted: true)
    flash[:notice] = "コメントを削除しました。"
    redirect_to post_path(params[:post_id])
  end
  private
  def comment_params
    params.require(:comment).permit(:text)
  end
end
