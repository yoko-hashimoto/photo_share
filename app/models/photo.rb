class Photo < ApplicationRecord
  validates :image, presence: true
  validates :caption, presence: true

  # Photoモデルのimageカラムに、ImageUploaderを紐付ける。
  mount_uploader :image, ImageUploader
end
