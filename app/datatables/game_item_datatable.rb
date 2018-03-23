class GameItemDatatable < AjaxDatatablesRails::Base
  def_delegators :@view, :link_to, :h, :edit_admin_game_item_path, :admin_game_items_path, :admin_game_item_path, :image_tag

  def sortable_columns
    @sortable_columns ||= ['GameItem.created_at']
  end

  def searchable_columns
    @searchable_columns ||= ['GameItem.title']
  end

  private

  def data
    records.map do |record|
      [
        link_to(record.title, admin_game_item_path(record)),
        image_tag(record.attachment.path,  height: 'auto', width: '100'),
        (record.eatable ? 'Да' : 'Нет'), 
        I18n.l(record.created_at, format: :default),
        link_to('Редактировать', edit_admin_game_item_path(record)),
        link_to('Удалить', admin_game_item_path(record), method: :delete, data: {confirm: 'Вы действительно хотите удалить запись?'})
      ]
    end
  end

  def get_raw_records
    GameItem.ordered
  end  
end
