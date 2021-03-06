class Post < ApplicationRecord
  acts_as_taggable
  
  validates :title, presence: true
  #validates :body, presence: true
  #validates :description, presence: true
  #validates :description, length: { maximum: 500 }
  
  has_many :attachments, as: :parent, dependent: :destroy, autosave: true, class_name: 'Attachment'
  has_many :comments, dependent: :destroy
  belongs_to :category
  belongs_to :author, class_name: 'User', foreign_key: 'user_id'
  
  after_create :notify_new_post_created
  
  accepts_nested_attributes_for :attachments, reject_if: :all_blank, allow_destroy: true
  
  scope :published, -> {where(published: true)}
  scope :ordered, -> {order('created_at DESC')}
  scope :by_category, -> (category_id) {where(category_id: category_id)}
  scope :find_by_title, -> (search) {where('title LIKE ?', "%#{search}%")}
  
  private 
  
  def notify_new_post_created
    #NewPostNotifyJob.perform_later(self)
    User.approved.each do |user|
      UserMailer.new_post_email(user, self).deliver_now
    end   
  end  
end
