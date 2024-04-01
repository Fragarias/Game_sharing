class Public::EndUsersController < ApplicationController
  before_action :authenticate_end_user!, except: [:index, :show]
  before_action :ensure_guest_user, only: [:edit]
  before_action :active_user_only, only: [:show]

  def index
    @end_user = current_end_user
    post_like_count = {}
    active_users = EndUser.where(is_active: true)
    active_users.each do |end_user| #退会したユーザを表示させない
      # 削除・非公開中の投稿を省き、いいねを多くもらっているユーザ順に表示する
      post_like_count.store(end_user, Like.where(post_id: Post.where(is_deleted: false, is_published: true, end_user_id: end_user.id).pluck(:id)).count)
    end
    @end_users = post_like_count.sort_by { |_, v| v }.reverse.to_h.keys
  end

  def show #退会ユーザは表示させない
    @end_user = EndUser.find(params[:id])
    if @end_user == current_end_user
      @posts = @end_user.posts.where(is_deleted: false).page(params[:page])
    else
      @posts = @end_user.posts.where(is_deleted: false, is_published: true).page(params[:page])
    end
  end

  def edit #guest以外アクセス可
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
    if end_user.update(is_active: false)
      reset_session
      end_user.remove_follow(end_user)
      end_user.user_has_many_delete(end_user)
      flash[:notice] = "退会しました。"
      redirect_to root_path
    end
  end

  private
  def end_user_params
    params.require(:end_user).permit(:profile_image, :name, :introduction, :email)
  end

  def ensure_guest_user #guestuserログイン用[:edit]
    @end_user = current_end_user
    if @end_user.name == "guestuser"
      redirect_to end_user_path(@end_user.id), notice: 'ゲストユーザーはプロフィール編集画面へ遷移できません。'
    end
  end

  def active_user_only #退会したユーザを表示させない[:show]
    @end_user = EndUser.find(params[:id])
    if @end_user.is_active == false
      redirect_to end_user_path(current_end_user.id)
    end
  end

end
