class Admin::EndUsersController < ApplicationController
  before_action :authenticate_admin!
  def index
    @end_users = EndUser.page(params[:page]).per(10)
  end

  def show
    @end_user = EndUser.find(params[:id])
    @game_bookmarks = @end_user.game_bookmarks.all
    @posts = @end_user.posts.page(params[:page]).per(10)
  end

  def edit
    @end_user = EndUser.find(params[:id])
  end

  def update
    end_user = EndUser.find(params[:id])
    if end_user.update(end_user_params)
      flash[:notice] = "ユーザー情報を更新しました。"
      redirect_to admin_end_user_path(end_user.id)
    else
      flash[:notice] = "ユーザー情報の更新に失敗しました。"
      redirect_to edit_admin_end_user_path
    end
  end

  private
  def end_user_params
    params.require(:end_user).permit(:profile_image, :name, :introduction, :email, :is_active)
  end
end
