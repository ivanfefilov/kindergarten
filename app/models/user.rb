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
  
  def full_name
    [first_name, last_name].join(' ')
  end           
end
