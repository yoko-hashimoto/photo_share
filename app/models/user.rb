class User < ApplicationRecord

  # userは複数のphotoと紐づいている
  has_many :photos
  
  # Userモデルのiconカラムに、IconUploaderを紐付ける。
  mount_uploader :icon, IconUploader
end
