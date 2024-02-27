class Public::GameBookmarksController < ApplicationController
  before_action :authenticate_end_user!
  def create
    community = Community.find(params[:community_id])
    bookmark = current_end_user.game_bookmarks.new(community_id: community.id)
    bookmark.save
    redirect_to community_path(community)
  end
  def destroy
    community = Community.find(params[:community_id])
    game_bookmark = current_end_user.game_bookmarks.find_by(community_id: community.id)
    game_bookmark.destroy
    redirect_to community_path(community.id)
  end
end
