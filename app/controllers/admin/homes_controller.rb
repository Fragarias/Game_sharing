class Admin::HomesController < ApplicationController
  before_action :authenticate_admin!
  def top # order('id DESC')...新着順（id降順）
    if params[:word]
      @new_posts = Post.where('title || text LIKE ?', "%#{params[:word]}%").order('id DESC').page(params[:page]).per(10)
    else
      @new_posts = Post.order('id DESC').page(params[:page]).per(10)
    end
  end
end
