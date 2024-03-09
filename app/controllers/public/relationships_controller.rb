class Public::RelationshipsController < ApplicationController
  before_action :authenticate_end_user!, except: [:index]
  def index
    @end_user = EndUser.find(params[:end_user_id])
    if params[:followers_id]
      # フォロワー一覧#Log_inユーザからフォローされているユーザ
      @end_users = @end_user.followers
    else
      # 画面遷移・フォロー中ユーザ一覧#Log_inユーザをフォローしているユーザ
      @end_users = @end_user.followings
    end
  end

  def create
    # # [フォロー先:パラメータ・フォロー主:Log_inユーザ] を探し、なければ作成
    current_end_user.follow(params[:end_user_id])
    #redirect_to root_path
  end
  def destroy
    # # [フォロー先:パラメータ。フォロー主:Log_inユーザ] を探して削除
    current_end_user.unfollow(params[:end_user_id])
    #redirect_to root_path
  end
end
