class CategoryDatatable < AjaxDatatablesRails::Base
  def_delegators :@view, :link_to, :edit_admin_category_path, :admin_category_path

  def sortable_columns
    @sortable_columns ||= ['Category.title']
  end

  def searchable_columns
    @searchable_columns ||= ['Category.title']
  end

  private

  def data
    records.map do |record|
      [
        record.title,
        link_to('Редактировать', edit_admin_category_path(record)),
        link_to('Удалить', admin_category_path(record), method: :delete, data: {confirm: 'Вы действительно хотите удалить запись?'})
      ]
    end
  end

  def get_raw_records
    Category.all
  end  
end
