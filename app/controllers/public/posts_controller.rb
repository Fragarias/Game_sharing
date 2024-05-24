class Public::PostsController < ApplicationController
  before_action :authenticate_end_user!, except: [:show]
  before_action :login_user_only, only: [:edit, :update, :destroy]
  before_action :published_post, only: [:show]
  def new
    @post = Post.new
    if params[:community_id]
      @community = Community.find(params[:community_id])
    end
  end

  def create
    post = Post.new(post_params)
    post.end_user_id = current_end_user.id
    if params[:publish].present?
      if post.save(context: :publicize)
        flash[:notice] = "投稿しました。"
        redirect_to post_path(post.id)
      else
        flash[:notice] = "投稿に失敗しました。"
        render :new
      end
    else
      post.is_published = false
      if post.save
        flash[:notice] = "下書き保存しました。"
        redirect_to post_path(post.id)
      else
        flash[:notice] = "下書き保存に失敗しました。"
        render :new
      end
    end
  end

  def index
    # 自分と自分がフォローしているユーザの投稿一覧
    posts = Post.where(end_user_id: [current_end_user.id, *current_end_user.following_ids], is_deleted: false, is_published: true).page(params[:page])
    @end_user = current_end_user
    if params[:latest]
      @posts = posts.latest
    elsif params[:old]
      @posts = posts.old
    elsif params[:like_count]
      @posts = posts.like_count
    elsif params[:comment_count]
      @posts = posts.comment_count
    elsif params[:random]
      @posts = posts.random
    else
      @posts = posts
    end
  end

  def show # 論理削除した投稿 もしくは 下書き投稿を表示させない
    @post = Post.find(params[:id])
    @end_user = @post.end_user
    @comments = @post.comments.where(is_deleted: false)
    @comment = Comment.new
  end

  def edit #ログインユーザの投稿じゃない場合は表示をさせない
    @post = Post.find(params[:id])
  end

  def update #ログインユーザの投稿じゃない場合は表示をさせない
    @post = Post.find(params[:id])
    if params[:publish].present?
      @post.attributes = post_params.merge(is_published: true)
      if @post.save(context: :publicize)
        # post.update(post_params, is_published: true)
        flash[:notice] = "内容を更新し、投稿しました。"
        redirect_to post_path(@post.id)
      else
        @post.update(is_published: false)
        flash[:notice] = "更新に失敗しました。"
        render :edit
      end
    else
      @post.update(is_published: false)
      if @post.update(post_params)
        #post.update(is_published: false, title: post_params[:title], text: post_params[:text])
        flash[:notice] = "下書きで更新しました。"
        redirect_to post_path(@post.id)
      else
        flash[:notice] = "更新に失敗しました。"
        render :edit
      end
    end
  end

  def destroy #ログインユーザの投稿じゃない場合は表示をさせない
    post = Post.find(params[:id])
    post.update(is_deleted: true)
    post.comments.each do |comment|
      comment.update(is_deleted: true)
    end
    flash[:notice] = "投稿を削除しました。"
    redirect_to end_user_path(current_end_user.id)
  end

  private
  def post_params
    params.require(:post).permit(:post_image, :community_id, :title, :text, :is_published, :is_deleted, tag_ids: [] )
  end

  def published_post # 削除済投稿と、ログインユーザ以外の下書き投稿は表示しない[:show]
    post = Post.find(params[:id]) # 表示したい場合にreturn
    return if end_user_signed_in? && post.end_user_id == current_end_user.id # ログインユーザの投稿の場合return
    if post.is_deleted == true
      # 投稿が削除されている ー リダイレクト
      redirect_to root_path
    else
      return if post.is_published == true # 投稿が削除されていない かつ 公開中 であればreturn
      # 投稿が削除されていないが、非公開中 ー リダイレクト
      redirect_to root_path
    end
  end

  def login_user_only # ログインユーザの投稿じゃない場合リダイレクト[:edit, :update, :destroy]
    post = Post.find(params[:id])
    return if end_user_signed_in? && post.end_user_id == current_end_user.id
    redirect_to post_path(post.id)
  end
end
