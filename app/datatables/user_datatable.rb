class UserDatatable < AjaxDatatablesRails::Base
  def_delegators :@view, :link_to, :h, :edit_admin_user_path, :admin_user_path

  def sortable_columns
    @sortable_columns ||= ['User.created_at']
  end

  def searchable_columns
    @searchable_columns ||= ['User.first_name', 'User.last_name']
  end

  private

  def data
    records.map do |record|
      [
        link_to(record.full_name, admin_user_path(record)),
        (record.is_admin ? 'Да' : 'Нет'),
        (record.approved ? 'Да' : 'Нет'), 
        I18n.l(record.created_at, format: :default),
        I18n.l(record.last_sign_in_at, format: :default),
        link_to('Редактировать', edit_admin_user_path(record)),
        link_to('Удалить', admin_user_path(record), method: :delete, data: {confirm: 'Вы действительно хотите удалить запись?'})
      ]
    end
  end

  def get_raw_records
    User.ordered.all
  end  
end
