class Public::EndUsersController < ApplicationController
  before_action :authenticate_end_user!, except: [:index, :show]
  def index
  end

  def show
  end

  def edit
  end

  def quit
  end
end
