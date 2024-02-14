class Admin::CommunitiesController < ApplicationController
  before_action :authenticate_admin!
  def new
    @community = Community.new
  end

  def create
    @community = Community.new(community_params)
    @community.save
    redirect_to admin_community_path
  end

  def index
  end

  def show
  end

  def edit
  end

  private
  def community_params
    params.require(:community).permit(:image, :name, :overview)
  end
end
