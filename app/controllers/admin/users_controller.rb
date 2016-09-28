class Admin::UsersController < Admin::AdminController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  layout 'admin'

  def index
    respond_to do |format|
      format.html
      format.json { render json: UserDatatable.new(view_context) }
    end
  end

  def show
  end

  def edit
  end

  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to admin_users_url, notice: 'Данные пользователя успешно обновлены.' }
        format.json { render :show, status: :ok, location: [:admin, @user] }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to admin_users_url, notice: 'Пользователь успешно удален' }
      format.json { head :no_content }
    end
  end
  
  private
    def set_user
      @user = params.key?('user_id') ? User.find(params[:user_id]) : User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:first_name, :last_name, :is_admin, :approved)
    end
end
