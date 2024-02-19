class Admin::TagsController < ApplicationController
  before_action :authenticate_admin!
  def index
    @tag = Tag.new
    @tags = Tag.all
  end
  def create
    tag = Tag.new(tag_params)
    tag.save
    flash[:notice] = "タグを登録しました。"
    redirect_to admin_tags_path
  end
  def update
    tag = Tag.find(params[:id])
    tag.update(tag_params)
    flash[:notice] = "タグ名を変更しました。"
    redirect_to admin_tags_path
  end
  def destroy
    @tag = Tag.find(params[:id])
    @tag.destroy
    flash[:notice] = "タグを削除しました。"
    redirect_to admin_tags_path
  end
  private
  def tag_params
    params.require(:tag).permit(:name)
  end
end
