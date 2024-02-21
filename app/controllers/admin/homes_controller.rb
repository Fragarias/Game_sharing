class Admin::HomesController < ApplicationController
  before_action :authenticate_admin!
  def top
    @new_posts = Post.order('id DESC') # 新着順（id降順）
  end
end
