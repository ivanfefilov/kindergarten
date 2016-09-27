class PostsController < ApplicationController
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
end
