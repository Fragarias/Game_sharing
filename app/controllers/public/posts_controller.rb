class Public::PostsController < ApplicationController
  before_action :authenticate_end_user!, except: [:index, :show]
  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.end_user_id = current_end_user.id
    @post.save
    # @post.tags.all.each do |tag|
    #   @post_tag = PostTag.new
    #   @post_tag.post_id = @post.id
    #   @post_tag.tag_id = tag.id
    #   @post_tag.save
    # end
    redirect_to post_path(@post.id)
  end

  def index
    @posts = Post.all
    @end_user = current_end_user
  end

  def show
    @post = Post.find(params[:id])
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
