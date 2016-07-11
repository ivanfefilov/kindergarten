class Attachment < ApplicationRecord

  mount_uploader :file, AttachmentUploader

  belongs_to :parent, polymorphic: true

  validates :file_name, presence: true
  validates :file_type, presence: true
  validates :file_size, presence: true
  validates :file, presence: true
  
  before_validation do
    if file
      self.file_name = file.filename if file_name.blank?
      self.file_type = file.content_type if file_type.blank?
      self.file_size = file.size if file_size.blank?
    end
  end

  def path
    file.url
  end

  def image?
    file_type.match(/\Aimage\//).present?
  end
  
  def to_json
    {
      id: id,
      type: file.content_type,
      url: file.url,
      thumb_url: file.url(:thumb),
      size: file.size,
      file_name: file.file.original_filename
    }
  end
end
