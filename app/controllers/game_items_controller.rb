class GameItemsController < ApplicationController

  def index
    @game_items = GameItem.all.shuffle
    render json: @game_items 
  end
end
