class Admin::TagsController < ApplicationController
  before_action :authenticate_admin!
  def index
    @tag = Tag.new
    @tags = Tag.all
  end
  def create
    tag = Tag.new(tag_params)
    if tag.save
      flash[:notice] = "タグを登録しました。"
    else
      flash[:notice] = "タグの登録に失敗しました。"
    end
    redirect_to admin_tags_path
  end
  def update
    tag = Tag.find(params[:id])
    if tag.update(tag_params)
      flash[:notice] = "タグ名を変更しました。"
    else
      flash[:notice] = "タグ名の変更に失敗しました。"
    end
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
