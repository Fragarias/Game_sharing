class Public::HomesController < ApplicationController
  def top # order('id DESC')...新着順（id降順）.  .page(params[:page]).per(8)
    posts = Post.where(is_deleted: false, is_published: true)
    if params[:word]
      @new_posts = posts.where('title || text LIKE ?', "%#{params[:word]}%").order('id DESC')
    elsif params[:latest]
      @new_posts = posts.latest
    elsif params[:old]
      @new_posts = posts.old
    elsif params[:like_count]
      @new_posts = posts.like_count
    elsif params[:random]
      @new_posts = posts.random
    else
      @new_posts = posts.order('id DESC')
    end
  end
end
