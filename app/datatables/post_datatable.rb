class PostDatatable < AjaxDatatablesRails::Base
  def_delegators :@view, :link_to, :h, :edit_admin_post_path, :admin_post_path, :admin_post_path

  def sortable_columns
    # Declare strings in this format: ModelName.column_name
    @sortable_columns ||= ['Post.title', 'Post.created_at']
  end

  def searchable_columns
    # Declare strings in this format: ModelName.column_name
    @searchable_columns ||= ['Post.title']
  end

  private

  def data
    records.map do |record|
      [
        link_to(record.title, admin_post_path(record)),
        record.title,
        (record.published ? 'Да' : 'Нет'), 
        I18n.l(record.created_at, format: :default),
        link_to('Посмотреть', admin_post_path(record)),
        link_to('Редактировать', edit_admin_post_path(record)),
        link_to('Удалить', admin_post_path(record), method: :delete, data: {confirm: 'Вы действительно хотите удалить запись?'})
      ]
    end
  end

  def get_raw_records
    Post.all
  end
end
