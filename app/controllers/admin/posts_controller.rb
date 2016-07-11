class Admin::PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy, :attachments, :attachment_create, :attachment_destroy]
  layout 'admin'

  # GET /admin/posts
  # GET /admin/posts.json
  def index
    #@posts = Post.all
    respond_to do |format|
      format.html
      format.json { render json: PostDatatable.new(view_context) }
    end
  end

  # GET /admin/posts/1
  # GET /admin/posts/1.json
  def show
  end

  # GET /admin/posts/new
  def new
    @post = Post.new
  end

  # GET /admin/posts/1/edit
  def edit
  end

  # POST /admin/posts
  # POST /admin/posts.json
  def create
    @post = Post.new(post_params)

    respond_to do |format|
      if @post.save
        format.html { redirect_to admin_posts_url, notice: 'Новость успешно создана.' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/posts/1
  # PATCH/PUT /admin/posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to [:admin, @post], notice: 'Новость успешно обновлена.' }
        format.json { render :show, status: :ok, location: [:admin, @post] }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/posts/1
  # DELETE /admin/posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to admin_posts_url, notice: 'Новость успешно удалена' }
      format.json { head :no_content }
    end
  end
  
  def attachments
    respond_to do |format|
      format.json{ render json: @post.attachments.map{|attachment| attachment.to_json} }
    end
  end

  def attachment_create
    attachment = @post.attachments.build(attachment_params)
    if attachment.save
      render json: { success: true, id: attachment.id, attachment: attachment.to_json }, status: 200
    else
      render json: { success: false, error: @post.errors.full_messages.join(',')}, status: 400
    end
  end

  def attachment_destroy
    attachment = @post.attachments.find(params[:attachment_id])
    if attachment.destroy
      render json: { success: true, message: "File deleted from server" }
    else
      render json: { success: false, message: attachment.errors.full_messages.join(',') }
    end
  end

  private
    def set_post
      @post = params.key?('post_id') ? Post.find(params[:post_id]) : Post.find(params[:id])
    end

    def post_params
      params.require(:post).permit(:title, :body, :published, :description, :category_id, :tag_list)
    end
    
    def attachment_params
      params.require(:attachment).permit(:file)
    end  
end
