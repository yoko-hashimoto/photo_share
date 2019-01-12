class User < ApplicationRecord
  # Userモデルのiconカラムに、IconUploaderを紐付ける。
  mount_uploader :icon, IconUploader
end
