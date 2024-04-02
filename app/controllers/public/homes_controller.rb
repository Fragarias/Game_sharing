class Public::HomesController < ApplicationController
  def top # order('id DESC')...新着順（id降順）
    posts = Post.where(is_deleted: false, is_published: true)
    if params[:word]
      @new_posts = posts.where('title || text LIKE ?', "%#{params[:word]}%").order('id DESC').page(params[:page]).per(8)
    else
      @new_posts = posts.order('id DESC').page(params[:page]).per(8)
    end
  end
end
