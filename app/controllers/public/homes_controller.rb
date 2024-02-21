class Public::HomesController < ApplicationController
  def top
    @new_posts = Post.order('id DESC') # 新着順（id降順）
  end
end
