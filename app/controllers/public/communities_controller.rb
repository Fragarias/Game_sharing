class Public::CommunitiesController < ApplicationController
  def index
    @communities = Community.all
  end

  def show
    @community = Community.find(params[:id])
    # @tags = Community.tags.all
    # @posts = Community.posts.all
  end
end
