class Photo < ApplicationRecord

  # photoは一人のuserに属している
  belongs_to :user
  
  validates :image, presence: true
  validates :caption, presence: true

  # Photoモデルのimageカラムに、ImageUploaderを紐付ける。
  mount_uploader :image, ImageUploader
end
