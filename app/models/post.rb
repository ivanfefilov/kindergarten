class Post < ApplicationRecord
  validates :title, presence: true
  validates :body, presence: true
  
  has_many :attachments, as: :parent, dependent: :destroy, autosave: true, class_name: 'Shoppe::Attachment'
end
