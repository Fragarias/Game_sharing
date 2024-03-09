class Public::RelationshipsController < ApplicationController
  before_action :authenticate_end_user!, except: [:index]
  def index
    @end_user = EndUser.find(params[:end_user_id])
    if params[:followers_id]
      # フォロワー一覧
      # @follows = Relationship.where(followees_id: params[:followers_id]) #Log_inユーザからフォローされているユーザ
      @follows = @end_user.follower(@end_user)
    else
      # 画面遷移・フォロー中ユーザ一覧
      # @follows = Relationship.where(followers_id: @end_user.id) #Log_inユーザをフォローしているユーザ
      @follows = @end_user.followed(@end_user)
    end
  end

  def create
    # [フォロー先:パラメータ・フォロー主:Log_inユーザ] を探し、なければ作成
    Relationship.find_or_create_by(followees_id: params[:followee_id], followers_id: current_end_user.id)
    redirect_to root_path
  end
  def destroy
    # [フォロー先:パラメータ。フォロー主:Log_inユーザ] を探して削除
    Relationship.find_by(followees_id: params[:id], followers_id: current_end_user.id).delete
    redirect_to root_path
  end
end
