# -*- encoding : utf-8 -*-
class BaseUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  storage :aliyun

  def store_dir
    'assets'
  end

  # def extension_white_list
  #   %w(jpg jpeg gif png)
  # end

  def filename
     "#{secure_token}" if original_filename.present?
  end

  protected
  def secure_token
    var = :"@#{mounted_as}_secure_token"
    model.instance_variable_get(var) or model.instance_variable_set(var, Digest::MD5.hexdigest(SecureRandom.uuid.to_s + Time.now.to_s + rand.to_s))
  end
end
