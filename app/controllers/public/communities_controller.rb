class Public::CommunitiesController < ApplicationController
  def index
    @communities = Community.all
  end

  def show
    @community = Community.find(params[:id])
    @tags = Tag.all
    if params[:tag_id]
      @tag = Tag.find(params[:tag_id])
      @posts = @tag.posts.where(community_id: @community.id, is_published: true, is_deleted: false)
    else
      @posts = @community.posts.where(is_published: true, is_deleted: false)
    end
  end
end
