class Public::EndUsersController < ApplicationController
  before_action :authenticate_end_user!, except: [:index, :show]
  before_action :ensure_guest_user, only: [:edit]

  def index
    @end_users = EndUser.all
  end

  def show
    @end_user = EndUser.find(params[:id])
  end

  def edit
    @end_user = current_end_user
  end

  def quit
    @end_user = current_end_user
  end

  def update
    @end_user = current_end_user
    if @end_user.update(end_user_params)
      flash[:notice] = "編集内容を保存しました。"
      redirect_to end_user_path(@end_user.id)
    else
      render :edit
    end
  end

  def withdraw
    end_user = current_end_user
    end_user.update(is_active: false)
    reset_session
    flash[:notice] = "退会しました。"
    redirect_to root_path
  end

  private
  def end_user_params
    params.require(:end_user).permit(:profile_image, :name, :introduction, :email)
  end

  def ensure_guest_user #guestuserログイン用
    @end_user = current_end_user
    if @end_user.name == "guestuser"
      redirect_to end_user_path(current_user) , notice: 'ゲストユーザーはプロフィール編集画面へ遷移できません。'
    end
  end

end
