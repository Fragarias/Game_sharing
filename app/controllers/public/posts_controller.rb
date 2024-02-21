class Public::PostsController < ApplicationController
  before_action :authenticate_end_user!, except: [:index, :show]
  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    #@post.end_user_id = current_end_user.id
    if params[:publish]
      @post.save
      flash[:notice] = "投稿しました。"
      redirect_to post_path(@post.id)
    else
      @post.update(is_published: false)
      flash[:notice] = "下書き保存しました。"
      redirect_to end_user_path(current_end_user.id)
    end
  end

  def index
    @posts = Post.all
    @end_user = current_end_user
    @game_bookmarks = @end_user.game_bookmarks.all
  end

  def show
    @post = Post.find(params[:id])
    @end_user = @post.end_user
    @game_bookmarks = @end_user.game_bookmarks.all
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    @post.update(post_params)
    redirect_to post_path(@post.id)
  end


  private
  def post_params
    params.require(:post).permit(:post_image, :community_id, :title, :text, :is_published, :is_deleted, tag_ids: [] )
  end
end
