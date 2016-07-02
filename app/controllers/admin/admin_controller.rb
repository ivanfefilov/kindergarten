class Admin::AdminController < ApplicationController
  before_filter :authenticate_user!
  before_filter :check_admin
  layout 'admin'
  
  private
  
  def check_admin
    current_user.is_admin ? true : (render text: 'У вас нет прав для редактирования этого раздела!')
  end  
end  
