class PostDatatable < AjaxDatatablesRails::Base
  def_delegators :@view, :link_to, :h, :edit_admin_post_path, :admin_post_path, :admin_post_path

  def sortable_columns
    @sortable_columns ||= ['Post.created_at']
  end

  def searchable_columns
    @searchable_columns ||= ['Post.title']
  end

  private

  def data
    records.map do |record|
      [
        link_to(record.title, admin_post_path(record)),
        record.description,
        (record.published ? 'Да' : 'Нет'), 
        I18n.l(record.created_at, format: :default),
        link_to('Редактировать', edit_admin_post_path(record)),
        link_to('Удалить', admin_post_path(record), method: :delete, data: {confirm: 'Вы действительно хотите удалить запись?'})
      ]
    end
  end

  def get_raw_records
    Post.all
  end  
end
