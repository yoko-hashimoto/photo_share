class Photo < ApplicationRecord

  # photoは一人のuserに属している
  belongs_to :user

  # １つのphotoは多数のユーザにお気に入りされ、photoが削除されると同時に、お気に入り情報も削除される
  has_many :favorites, dependent: :destroy
  # favorite_users により、 photoのidと一致するphoto_idを持つfavoritesテーブルのレコードを全て取りだし、
  # そのfavoritesテーブルのレコードがもっているuser_idの数字と同じidを持つuserを全件取得できる
  has_many :favorite_users, through: :favorites, source: :user

  validates :image, presence: true
  validates :caption, presence: true

  # Photoモデルのimageカラムに、ImageUploaderを紐付ける。
  mount_uploader :image, ImageUploader
end
