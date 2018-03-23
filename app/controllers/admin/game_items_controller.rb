class Admin::GameItemsController < ApplicationController
  before_action :set_game_item, only: [:show, :edit, :update, :destroy]
  layout 'admin'

  def index
    respond_to do |format|
      format.html
      format.json { render json: GameItemDatatable.new(view_context) }
    end
  end

  def show
  end

  def new
    @game_item = GameItem.new
    @game_item.attachment = Attachment.new
  end

  def edit
  end

  def create
    @game_item = GameItem.new(game_item_params)

    respond_to do |format|
      if @game_item.save
        format.html { redirect_to admin_game_items_url, notice: 'Запись успешно создана.' }
        format.json { render :show, status: :created, location: @game_item }
      else
        format.html { render :new }
        format.json { render json: @game_item.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @game_item.update(game_item_params)
        format.html { redirect_to [:admin, @game_item], notice: 'Запись успешно обновлена.' }
        format.json { render :show, status: :ok, location: [:admin, @game_item] }
      else
        format.html { render :edit }
        format.json { render json: @game_item.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @game_item.destroy
    respond_to do |format|
      format.html { redirect_to admin_game_items_url, notice: 'Запись успешно удалена' }
      format.json { head :no_content }
    end
  end
  
  private
    def set_game_item
      @game_item = GameItem.find(params[:id])
    end

    def game_item_params
      params.require(:game_item).permit!
    end
end
