class Post < ApplicationRecord
  acts_as_taggable
  
  validates :title, presence: true
  validates :body, presence: true
  validates :description, presence: true
  validates :description, length: { maximum: 500 }
  
  has_many :attachments, as: :parent, dependent: :destroy, autosave: true, class_name: 'Attachment'
  belongs_to :category
  
  accepts_nested_attributes_for :attachments, reject_if: :all_blank, allow_destroy: true
  
  scope :published, -> {where(published: true)}
  scope :ordered, -> {order(:created_at)}
end
