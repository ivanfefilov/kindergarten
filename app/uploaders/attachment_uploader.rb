# encoding: utf-8

class AttachmentUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  def store_dir
    "attachment/#{model.id}"
  end

  def image?(_new_file)
    file.content_type.include? 'image'
  end

  def not_image?(_new_file)
    !file.content_type.include? 'image'
  end

  version :thumb, if: :image? do
    #process resize_and_pad: [200, 200]
    process resize_to_fit: [200, 200]
  end
end
