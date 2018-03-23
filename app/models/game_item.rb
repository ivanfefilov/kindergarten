class GameItem < ApplicationRecord
  validates :title, presence: true
  has_one :attachment, as: :parent, dependent: :destroy, autosave: true, class_name: "Attachment"
  
  accepts_nested_attributes_for :attachment, reject_if: :all_blank, allow_destroy: true
  
  scope :ordered, -> {order(:created_at)}
end
