class Comment < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: 'user_id'
  belongs_to :post
  
  validates :body, presence: true  
  validates :body, length: { maximum: 300 }
  
  scope :ordered, -> {order('created_at DESC')}
end
