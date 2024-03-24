class Public::HomesController < ApplicationController
  def top # order('id DESC')...新着順（id降順）
    if params[:word]
      @new_posts = Post.where('title || text LIKE ?', "%#{params[:word]}%", is_deleted: false, is_published: true).order('id DESC').page(params[:page]).per(8)
    else
      @new_posts = Post.where(is_deleted: false, is_published: true).order('id DESC').page(params[:page]).per(8)
    end
  end
end
