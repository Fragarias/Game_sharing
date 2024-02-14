class Admin::EndUsersController < ApplicationController
  before_action :authenticate_admin!
  def index
    @end_users = EndUser.all
  end

  def show
    @end_user = EndUser.find(params[:id])
    @game_bookmarks = @end_user.game_bookmarks.all
    @posts = @end_user.posts.all
  end

  def edit
    @end_user = EndUser.find(params[:id])
  end

  def update
    end_user = EndUser.find(params[:id])
    end_user.update(end_user_params)
    redirect_to admin_end_user_path(end_user.id)
  end

  private
  def end_user_params
    params.require(:end_user).permit(:profile_image, :name, :introduction, :email, :is_active)
  end
end
