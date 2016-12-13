class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :check_approved
  before_action :set_post, only: %i(show create_comment destroy_comment)
  after_action :discard_flash, only: %i(create_comment destroy_comment)

  # GET /posts
  def index
    if params[:category_id].present?
      @category = Category.find params[:category_id] 
      @posts = Post.by_category(params[:category_id]).published.ordered.page params[:page]
    else
      @posts = Post.published.ordered.page params[:page]
    end
    @posts = @posts.find_by_title(params[:search]) if params.key?(:search)  
  end

  # GET /posts/1
  def show
  end
  
  def create_comment
    @comment = @post.comments.create(user_id: current_user.id, body: params[:body])
    
    respond_to do |format|
      format.html {redirect_to posts_path}
      format.js {flash.now[:notice] = 'Комментарий успешно создан'}
    end   
  end  
  
  def destroy_comment
    @comment = @post.comments.find params[:comment_id]
    @comment.destroy if @comment
        
    respond_to do |format|
      format.html {redirect_to posts_path}
      format.js 
    end   
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
  
  def discard_flash
    flash.discard if request.xhr? 
  end   
end
