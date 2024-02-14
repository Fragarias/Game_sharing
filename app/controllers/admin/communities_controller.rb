class Admin::CommunitiesController < ApplicationController
  before_action :authenticate_admin!
  def new
    @community = Community.new
  end

  def create
    @community = Community.new(community_params)
    @community.save
    redirect_to admin_community_path(@community.id)
  end

  def index
    @communities = Community.all
  end

  def show
    @community = Community.find(params[:id])
  end

  def edit
    @community = Community.find(params[:id])
  end

  private
  def community_params
    params.require(:community).permit(:image, :name, :overview)
  end
end
