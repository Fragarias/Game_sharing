class Admin::HomesController < ApplicationController
  before_action :authenticate_admin!
  def top
    if params[:word]
      @new_posts = Post.where('title || text LIKE ?', "%#{params[:word]}%").order('id DESC')
    else
      @new_posts = Post.order('id DESC') # 新着順（id降順）
    end
  end
end
