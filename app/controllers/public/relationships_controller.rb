class Public::RelationshipsController < ApplicationController
  before_action :authenticate_end_user!, except: [:index]
  def index
  end
end
