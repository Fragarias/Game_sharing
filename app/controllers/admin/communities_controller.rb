class Admin::CommunitiesController < ApplicationController
  before_action :authenticate_admin!
  def new
    @community = Community.new
  end

  def create
    community = Community.new(community_params)
    community.save
    redirect_to admin_community_path(community.id)
  end

  def index
    @communities = Community.page(params[:page]).per(10)
  end

  def show
    @community = Community.find(params[:id])
    @tags = Tag.all
    if params[:tag_id]
      @tag = Tag.find(params[:tag_id])
      @posts = @tag.posts.where(community_id: @community.id).page(params[:page]).per(10)
    else
      @posts = @community.posts.page(params[:page]).per(10)
    end
  end

  def edit
    @community = Community.find(params[:id])
  end

  def update
    community = Community.find(params[:id])
    community.update(community_params)
    redirect_to admin_community_path(community.id)
  end

  private
  def community_params
    params.require(:community).permit(:image, :name, :overview)
  end
end
