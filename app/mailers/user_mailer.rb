class UserMailer < ApplicationMailer
  def approved_email(user)
    @user = user
    mail(to: @user.email, subject: 'Ваш аккаунт подтверждён')
  end
  
  def blocked_email(user)
    @user = user
    mail(to: @user.email, subject: 'Ваш аккаунт заблокирован')
  end
  
  def new_user_email(user)
    @user = user
    mail(to: app_config.mail_to, subject: 'New user registered')
  end
  
  def new_post_email(user, post)
    @post = post
    @user = user
    mail(to: @user.email, subject: 'Новость из садика добавлена')
  end      
end
