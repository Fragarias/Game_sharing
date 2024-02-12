class Public::PostsController < ApplicationController
  before_action :authenticate_end_user!, except: [:index, :show]
  def new
  end

  def index
  end

  def show
  end

  def edit
  end
end
