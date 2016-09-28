class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :check_approved
  before_action :set_post, only: :show

  # GET /posts
  def index
    @posts = Post.published.ordered.page params[:page]
  end

  # GET /posts/1
  def show
  end

  private
  
  def set_post
    @post = Post.find params[:id]
  end
  
  def check_approved
    unless current_user && current_user.approved 
      render 'pages/user_not_approved'
      return
    end  
  end  
end
