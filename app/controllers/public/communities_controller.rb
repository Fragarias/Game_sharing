class Public::CommunitiesController < ApplicationController
  def index
    @communities = Community.all
  end

  def show
    @community = Community.find(params[:id])
    @tags = Tag.all
    @posts = @community.posts.all
  end
end
