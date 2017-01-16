class CardImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  storage :file

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}"
  end

  process resize_to_fit: [360, 360]
  process convert: 'jpg'

  def extension_white_list
    %w(jpg jpeg gif png)
  end

  def filename
    "#{model.id}.#{file.extension.downcase}" if original_filename
  end
end
