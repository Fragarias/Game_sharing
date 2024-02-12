class Public::EndUsersController < ApplicationController
  before_action :authenticate_end_user!, except: [:index, :show]
  def index
  end

  def show
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
      #flash[:notice] = "編集内容を保存しました。"
      redirect_to end_user_path(@end_user.id)
    else
      render :edit
    end
  end

  private
  def end_user_params
    params.require(:end_user).permit(:name, :introduction, :email)
  end

end
