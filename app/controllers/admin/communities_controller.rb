class Admin::CommunitiesController < ApplicationController
  before_action :authenticate_admin!
  def new
    @community = Community.new
  end

  def create
    community = Community.new(community_params)
    if community.save
      flash[:nootice] = "コミュニティを登録しました。"
      redirect_to admin_community_path(community.id)
    else
      flash[:notice] = "コミュニティの登録に失敗しました。"
      redirect_to new_admin_community_path
    end
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
    if community.update(community_params)
      flash[:notice] = "コミュニティの登録内容を更新しました。"
      redirect_to admin_community_path(community.id)
    else
      flash[:notice] = "コミュニティの更新に失敗しました。"
      redirect_to edit_admin_community_path
    end
  end

  private
  def community_params
    params.require(:community).permit(:image, :name, :overview)
  end
end
