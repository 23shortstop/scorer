class ImageUploader < CarrierWave::Uploader::Base
  storage :file

  def move_to_store
    true
  end

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{model.id}/#{mounted_as}"
  end

end
