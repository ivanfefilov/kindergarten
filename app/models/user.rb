class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         
  validates :first_name, presence: true
  validates :last_name, presence: true
  
  has_many :posts, dependent: :nullify
  has_many :comments, dependent: :destroy
  
  scope :ordered, -> {order('created_at ASC')}
  scope :approved, -> {where(approved: true)}
  scope :admins, -> {where(is_admin: true)}
  
  after_create :send_new_user_signup_notif
  after_update :notify_user_if_approved_changed
  
  def full_name
    [first_name, last_name].join(' ')
  end
  
  private
  
  def send_new_user_signup_notif
    UserMailer.new_user_email(self).deliver_now
  end
  
  def notify_user_if_approved_changed
    UserMailer.approved_email(self).deliver_now if approved_changed?(from: false, to: true)
    UserMailer.blocked_email(self).deliver_now if approved_changed?(from: true, to: false)
  end               
end
