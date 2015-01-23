# -*- encoding : utf-8 -*-
class UserUploader < BaseUploader

  version :for_show do
    process :resize_to_fill => [192, 192]
  end
  
  version :thumb do
    process :resize_to_fit => [100, 100]
  end

  version :test do
  	process :resize_to_fit => [100, 100]
  end
end
